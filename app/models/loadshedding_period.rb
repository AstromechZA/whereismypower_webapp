require 'active_support/core_ext'

class LoadsheddingPeriod < ActiveRecord::Base

  # =========== instance methods ===========

  before_save do
    self.month_order = self.day_of_month * 12 + self.period
  end


  def is_load_shedding?(stage)
    case stage
    when 1
      return self.is_load_shedding1
    when 2
      return self.is_load_shedding2
    when 3
      return self.is_load_shedding3
    when 4
      return self.is_load_shedding4
    else
      raise "Unknown stage: #{stage}"
    end
  end

  # =========== class methods ===========

  def self.ls_column(stage)
    case stage
    when 1
      return :is_load_shedding1
    when 2
      return :is_load_shedding2
    when 3
      return :is_load_shedding3
    when 4
      return :is_load_shedding4
    else
      raise "Unknown stage: #{stage}"
    end
  end

  def self.areas_shedding(stage, datetime=nil)
    # if datetime was not provided, set to now
    datetime ||= Time.now
    # calculate time constants
    day_of_month = datetime.day
    period_main = (datetime.hour * 60 + datetime.min) / 120

    areas_loadshedding = self.where(day_of_month: day_of_month, period: period_main, self.ls_column(stage) => true).map(&:area)

    # because periods awkwardly overlap, determine the extended period if required
    if datetime.min <= 30 and datetime.hour.even?

      # determine next period and day_of_month
      period_ext = (period_main - 1)
      if period_ext < 0
        period_ext = 11
        day_of_month -= 1
        if day_of_month < 1
          day_of_month = (datetime - 24*60*60).end_of_month.day
        end
      end

      areas_loadshedding |= self.where(day_of_month: day_of_month, period: period_ext, self.ls_column(stage) => true).map(&:area)
    end

    return areas_loadshedding.sort
  end

  def self.is_area_shedding?(area, stage, datetime=nil)
    # if datetime was not provided, set to now
    datetime ||= Time.now
    # calculate time constants
    day_of_month = datetime.day
    period_main = (datetime.hour * 60 + datetime.min) / 120

    # get
    r = self.find_by(day_of_month: day_of_month, period: period_main, area: area)
    unless r.nil?
      return r.is_load_shedding? stage
    end

    # because periods awkwardly overlap, determine the extended period if required
    if datetime.min <= 30 and datetime.hour.even?

      # determine next period and day_of_month
      period_ext = (period_main - 1)
      if period_ext < 0
        period_ext = 11
        day_of_month -= 1
        if day_of_month < 1
          day_of_month = (datetime - 24*60*60).end_of_month.day
        end
      end

      # get
      r = self.find_by(day_of_month: day_of_month, period: period_ext, area: area)
      unless r.nil?
        return r.is_load_shedding? stage
      end
    end
    return false
  end

  def self.next_loadshed_time(area, stage, datetime=nil)
    # if datetime was not provided, set to now
    datetime ||= Time.now
    period_main = (datetime.hour * 60 + datetime.min) / 120
    month_order_main = datetime.day * 12 + period_main

    r = self.where('area = ? AND month_order > ?', area, month_order_main).first
    unless r.nil?
      datetime = datetime.change day: r.day_of_month
      return datetime.change hour: r.period * 2, minute: 0, second: 0
    end

    r = self.where('area = ? AND month_order > ?', area, 0).first
    datetime = datetime.change day: r.day_of_month
    datetime = datetime.advance months: 1
    return datetime.change hour: r.period * 2, minute: 0, second: 0
  end

end
