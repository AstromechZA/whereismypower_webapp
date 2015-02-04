class ApiController < ApplicationController
  protect_from_forgery except: [:get_status, :list_areas, :get_schedule]

  respond_to :json

  STAGENAME_TRANSLATIONS = {
    'stage 1' => 1,
    'stage1' => 1,
    'stage 2'=>  2,
    'stage2' => 2,
    'stage 3a' => 3,
    'stage3a' => 3,
    'stage 3b' => 4,
    'stage3b' => 4,
    '1' => 1,
    '2' => 2,
    '3a' => 3,
    '3b' => 4,
    '3' => 3,
    '4' => 4
  }

  def index
  end

  def get_status
    u = Update.last
    if u.nil?
      render json: {active_stage: nil, timestamp: nil}, :callback => params['callback']
    else
      render json: {active_stage: u.stage, timestamp: u.updated_at}, :callback => params['callback']
    end
  end

  def list_areas
    render json: Area.all.map { |a| {area_id: a.code, name: a.name, description: a.long_name} }, :callback => params['callback']
  end

  def get_schedule
    # check missing params
    [:area, :date, :stage].each do |variable|
      if params[variable].nil?
        render json: {error: "Missing '#{variable}' parameter"}, status: 500, :callback => params['callback']
        return
      end
    end

    case params[:date]
    when 'today'
      date = Date.today
    when 'tomorrow'
      date = Date.today + 1
    else
      begin
        date = Date.parse(params[:date])
      rescue Exception => e
        puts e
        render json: {error: "Badly formatted date: #{params[:date]}"}, status: 500, :callback => params['callback']
        return
      end
    end

    begin
      stage = STAGENAME_TRANSLATIONS.fetch(params[:stage].downcase)
    rescue Exception => e
      puts e
      render json: {error: "Unknown stage: #{params[:stage]}"}, status: 500, :callback => params['callback']
      return
    end

    area = params[:area].to_i
    unless (1..16) === area
      render json: {error: "Area number not in range 1-16: #{area}"}, status: 500, :callback => params['callback']
      return
    end

    r = Schedule.find_by(area: area, day_of_month: date.day, stage: stage)
    if r.nil?
      render json: {error: "Schedule not found"}, status: 404, :callback => params['callback']
      return
    else
      render json: {outages: r.outages, area_id: r.area, stage: r.stage, date: date, day_of_month: date.day}, :callback => params['callback']
      return
    end
  end

end
