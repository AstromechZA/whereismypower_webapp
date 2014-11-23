require 'net/http'

class SchedulesController < ApplicationController

  def recheck
    uri = 'http://www.capetown.gov.za/en/electricity/Pages/LoadShedding.aspx'
    response = Net::HTTP.get_response(URI.parse(uri))

    m = /class\="ms-rteForeColor-2 ms-rteFontSize-3".*?\>(.*?)\<\/div\>/.match(response.body)
    banner_content = m[1].gsub(/\<.*?\>/, ' ')
    puts banner_content

    cpt = Region.find_by(name: 'Cape Town')
    cpt.is_load_shedding = false
    cpt.active_schedule_id = nil

    puts "'#{cpt.schedules.to_a}'"
    cpt.schedules.each do |schedule|
      if banner_content.include? schedule.name.upcase
        cpt.is_load_shedding = true
        cpt.active_schedule_id = schedule.id
      end
    end
    cpt.save()

    if cpt.is_load_shedding
      redirect_to root_path, notice: "Cape Town : LoadShedding = #{cpt.is_load_shedding}, Schedule = #{cpt.active_schedule.name}"
    else
      redirect_to root_path, notice: "Cape Town : No longer load shedding"
    end
  end

end
