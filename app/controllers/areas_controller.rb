class AreasController < ApplicationController

  def index
    @areas = Area.all
    @currently_loadshedding = LoadsheddingPeriod.areas_shedding ApplicationController.current_stage
  end

end
