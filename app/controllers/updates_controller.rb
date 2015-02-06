require 'net/http'
require 'nokogiri'
require 'open-uri'

class UpdatesController < ApplicationController
  newrelic_ignore only: [:recheck]

  def latest
    @latest_updates = Update.order(updated_at: :desc).limit(20)
  end

  def get_eskom_status
    puts "Scraping eskom.co.za for load shedding status"
    uri = URI.parse('http://loadshedding.eskom.co.za/LoadShedding/GetStatus')
    r = Net::HTTP.get(uri).to_i
    puts "Eskom API returned #{r}"
    case r
    when 1
      return 0
    when 2..5
      return r - 1
    else
      raise "Unknown status code #{r}."
    end
  end

  def get_cptgov_status
    puts "Scraping capetown.gov.za for load shedding status"
    nhtml = Nokogiri::HTML(open('http://www.capetown.gov.za/en/electricity/Pages/LoadShedding.aspx'))
    nhtml.css('table tr td .CityArticleTitle').each do |e|
      m = /CURRENTLY EXPERIENCING[a-z\s]+ STAGE\s?([123][AB]?)/i.match(e.text)
      unless m.nil?
        case m[1].upcase
        when '1'
          return 1
        when '2'
          return 2
        when '3A'
          return 3
        when '3B'
          return 4
        end
      end
      if /LOADSHEDDING HAS BEEN SUSPENDED UNTIL FURTHER NOTICE/i =~ e.text
        puts "Capetown says not currently load shedding"
        return 0
      end
    end
    nil
  end

  def recheck
    source_msg = 'eskom.co.za'
    active_stage = get_cptgov_status()
    unless active_stage.nil?
      source_msg = 'capetown.gov.za'
    else
      active_stage = get_eskom_status()
    end

    active_stage = nil if active_stage == 0
    last_update = Update.last
    if last_update.nil? or last_update.stage != active_stage
      last_update = Update.create(
        is_load_shedding_active: (not active_stage.nil?),
        stage: active_stage,
        source: source_msg)
    else
      last_update.source = source_msg
      last_update.touch
    end

    redirect_to latest_updates_path, notice: "LoadShedding Status: #{ApplicationController.convert_stage_code_to_name(active_stage)} Updated: #{last_update.updated_at}"
  end

end
