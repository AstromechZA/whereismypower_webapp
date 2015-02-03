class SchedulesController < ApplicationController

  def show
    @date = params[:date]
    if @date == 'today'
      @date = Date.today
    elsif @date == 'tomorrow'
      @date = Date.today + 1
    else
      @date = Date.parse(@date)
    end

    @area = Area.find_by!(code: params[:area])
    @schedules = Schedule.where(area: params[:area], day_of_month: @date.day, stage: [1,2,3,4])
    @current_stage = ApplicationController.current_stage
  end

  def pick_date
    @area = Area.find_by(code: params[:area])
  end

end
