class AreasController < ApplicationController

  def show
    @area = Area.find(params[:id])
    @region = @area.region
    @schedules = @area.area_schedules
  end

end
