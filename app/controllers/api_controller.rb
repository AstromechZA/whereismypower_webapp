require 'time'

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

  STAGENUM_MAP = ['No Load Shedding', 'Stage 1', 'Stage 2', 'Stage 3A', 'Stage 3B']

  PERIOD_TIMES = [
      '00:00 - 02:30',
      '02:00 - 04:30',
      '04:00 - 06:30',
      '06:00 - 08:30',
      '08:00 - 10:30',
      '10:00 - 12:30',
      '12:00 - 14:30',
      '14:00 - 16:30',
      '16:00 - 18:30',
      '18:00 - 20:30',
      '20:00 - 22:30',
      '22:00 - 00:30'
  ]

  def index
  end

  def get_status
    u = Update.last
    if u.nil?
      render json: {active_stage: nil, active_stage_name: nil, timestamp: nil}, callback: params['callback']
    else
      render json: {
        active_stage: u.stage,
        active_stage_name: STAGENUM_MAP[u.stage || 0] ,
        timestamp: u.updated_at
      }, callback: params['callback']
    end
  end

  def list_areas
    render json: Area.all.map { |a| {area_id: a.code, name: a.name, description: a.long_name} }, callback: params['callback']
  end

  def get_schedule
    # check missing params
    [:area, :date, :stage].each do |variable|
      if params[variable].nil?
        render json: {error: "Missing '#{variable}' parameter"}, status: 400, callback: params['callback']
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
        render json: {error: "Badly formatted date: '#{params[:date]}'"}, status: 400, callback: params['callback']
        return
      end
    end

    begin
      stage = STAGENAME_TRANSLATIONS.fetch(params[:stage].downcase)
    rescue Exception => e
      render json: {error: "Unknown stage: '#{params[:stage]}'"}, status: 400, callback: params['callback']
      return
    end

    area = params[:area].to_i
    unless (1..16) === area
      render json: {error: "Area number not in range 1-16: #{area}"}, status: 400, callback: params['callback']
      return
    end

    r = LoadsheddingPeriod
      .select(:period)
      .where(area: area, day_of_month: date.day, "is_load_shedding#{stage}" => true)
      .map { |e| PERIOD_TIMES[e.period] }

    render json: {outages: r, area_id: area, stage: stage, date: date, day_of_month: date.day}, callback: params['callback']
    return
  end

  def get_next_loadshedding
    # check missing params
    [:area, :stage].each do |variable|
      if params[variable].nil?
        render json: {error: "Missing '#{variable}' parameter"}, status: 400, callback: params['callback']
        return
      end
    end

    # validate stage param
    begin
      stage = STAGENAME_TRANSLATIONS.fetch(params[:stage].downcase)
    rescue Exception => e
      render json: {error: "Unknown stage: '#{params[:stage]}'"}, status: 400, callback: params['callback']
      return
    end

    # validate area param
    area = params[:area].to_i
    unless (1..16) === area
      render json: {error: "Area number not in range 1-16: #{area}"}, status: 400, callback: params['callback']
      return
    end

    # get period
    r = LoadsheddingPeriod.next_loadshed_time(area, stage, Time.now())

    if r.nil?
      render json: {error: "No loadshedding periods could be found for area #{area} and stage #{stage}"}, status: 400, callback: params['callback']
    else
      # convert to client variables
      next_outage = r.iso8601()
      next_outage_period = PERIOD_TIMES[r.hour / 2]
      # output
      render json: {area_id: area, stage: stage, next_outage: next_outage, next_outage_period: next_outage_period}
    end
    return
  end

end
