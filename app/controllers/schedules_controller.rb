class SchedulesController < ApplicationController

  def show
    @date = params[:date]
    if @date == 'today' or @date.nil?
      @date = Date.today
    elsif @date == 'tomorrow'
      @date = Date.today + 1
    else
      @date = Date.parse(@date)
    end

    @area = Area.find_by!(code: params[:area])
    periods = LoadsheddingPeriod
      .select(:is_load_shedding1, :is_load_shedding2, :is_load_shedding3, :is_load_shedding4)
      .where(area: params[:area], day_of_month: @date.day)
    attrperiods = periods.map { |e| [e.is_load_shedding1, e.is_load_shedding2, e.is_load_shedding3, e.is_load_shedding4] }
    @schedules = attrperiods.transpose
    @current_stage = ApplicationController.current_stage
  end

  def show_month
    @area = Area.find_by!(code: params[:area])
    @periods_groups = LoadsheddingPeriod
      .where("area = ? AND day_of_month < 17", @area.code).group_by {|e| e.period}
  end

  def pick_date
    @area = Area.find_by(code: params[:area])
  end

end
