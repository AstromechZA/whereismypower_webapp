class RegionsController < ApplicationController

  def index
    @regions = Region.all
  end

  def show
    @region = Region.find(params[:id])

    @areas = @region.areas.sort_by {|r| [r.name.size, r.name.downcase]}
  end

end
