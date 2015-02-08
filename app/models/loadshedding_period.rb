require 'active_support/core_ext'

class LoadsheddingPeriod < ActiveRecord::Base

  # =========== instance methods ===========

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

end
