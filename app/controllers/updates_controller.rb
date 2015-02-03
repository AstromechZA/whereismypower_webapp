require 'net/http'
require 'open-uri'

class UpdatesController < ApplicationController

  def latest
    @latest_updates = Update.order(updated_at: :desc).limit(20)
  end

  def recheck
    uri = URI.parse('http://loadshedding.eskom.co.za/LoadShedding/GetStatus')
    r = Net::HTTP.get(uri).to_i

    case r
    when 1
      active_stage = nil
    when 2..5
      active_stage = r - 1
    end

    last_update = Update.last
    if last_update.nil? or last_update.stage != active_stage
      last_update = Update.create(
        is_load_shedding_active: (not active_stage.nil?),
        stage: active_stage
      )
    else
      last_update.touch
    end

    redirect_to latest_updates_path, notice: "LoadShedding Status: #{ApplicationController.convert_stage_code_to_name(active_stage)} Updated: #{last_update.updated_at}"
  end

end
