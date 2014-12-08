require 'net/http'
require 'nokogiri'
require 'open-uri'

class RegionUpdatesController < ApplicationController

  def latest
    @latest_updates = RegionUpdate.includes(:region).order(created_at: :desc).limit(20)
  end

  def recheck
    nhtml = Nokogiri::HTML(open('http://loadshedding.eskom.co.za'))

    banner = nhtml.css('#loadshedstatus #lsstatus').to_s
    banner_content = ActionController::Base.helpers.strip_tags(banner).upcase

    puts banner_content

    cpt = Region.find_by(name: 'Cape Town')
    cpt.is_load_shedding = false
    cpt.active_schedule_id = nil

    shedule_name = nil

    puts "'#{cpt.schedules.to_a}'"
    cpt.schedules.each do |schedule|
      if banner_content.include? schedule.name.upcase
        cpt.is_load_shedding = true
        cpt.active_schedule_id = schedule.id
        shedule_name = schedule.name
        break
      end
    end
    cpt.save()

    RegionUpdate.create(
      region: cpt,
      is_load_shedding_active: cpt.is_load_shedding,
      active_schedule_id: cpt.active_schedule_id,
      active_schedule_name: shedule_name
    )

    redirect_to latest_region_updates_path
  end

end
