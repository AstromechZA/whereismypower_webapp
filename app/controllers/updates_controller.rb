require 'net/http'
require 'open-uri'

class UpdatesController < ApplicationController

  def latest
    @latest_updates = Update.order(created_at: :desc).limit(20)
  end

  def recheck
    uri = URI.parse('http://loadshedding.eskom.co.za/LoadShedding/GetStatus')
    r = Net::HTTP.get(uri)

    case r.to_i
    when 1
      active_stage = nil
    when 2
      active_stage = 1
    when 3
      active_stage = 2
    when 4
      active_stage = 3
    when 5
      active_stage = 4
    end

    Update.create(
      is_load_shedding_active: (not active_stage.nil?),
      stage: (active_stage.nil? ? nil : active_stage)
    )

    redirect_to latest_updates_path
  end

end
