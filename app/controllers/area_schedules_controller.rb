class AreaSchedulesController < ApplicationController


  def show
    @area_schedule = AreaSchedule.find(params[:id])
    @area = @area_schedule.area
    @region = @area.region
    @schedule = @area_schedule.schedule
  end

end
