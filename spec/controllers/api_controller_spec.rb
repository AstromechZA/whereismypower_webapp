require 'rails_helper'

RSpec.describe ApiController, type: :controller do

  describe 'GET get_status' do
    it 'returns last status if there are updates' do
      get :get_status
      expect(JSON.parse(response.body)).to eq({
        'active_stage' => nil,
        'timestamp' => nil,
        'active_stage_name' => nil})
    end
    it 'returns last status if there are updates' do
      u = Update.create(
        is_load_shedding_active: true,
        stage: 1,
        source: 'capetown.gov.za'
      )
      get :get_status
      expect(JSON.parse(response.body)['active_stage']).to eq(1)
      expect(JSON.parse(response.body)['active_stage_name']).to eq('Stage 1')
      expect(JSON.parse(response.body)['timestamp']).to_not be_nil
    end
    it 'returns last status even if the last update is nil' do
      u = Update.create(
        is_load_shedding_active: false,
        stage: nil,
        source: 'capetown.gov.za'
      )
      get :get_status
      expect(JSON.parse(response.body)['active_stage']).to eq(nil)
      expect(JSON.parse(response.body)['active_stage_name']).to eq('No Load Shedding')
      expect(JSON.parse(response.body)['timestamp']).to_not be_nil
    end
  end

  describe 'GET list_areas' do
    it 'returns correct list' do
      Area.create(
        name: 'Area 1',
        long_name: 'Area 1 description',
        code: 1
      )
      Area.create(
        name: 'Area 2',
        long_name: 'Area 2 description',
        code: 2
      )
      get :list_areas
      expect(JSON.parse(response.body)).to eq([
        {"area_id"=>1, "name"=>"Area 1", "description"=>"Area 1 description"},
        {"area_id"=>2, "name"=>"Area 2", "description"=>"Area 2 description"}])
    end
  end

  describe 'GET get_schedule' do
    let!(:today) { Date.today }
    let!(:tomorrow) { Date.today + 1}

    it 'returns the correct schedule for the day' do
      LoadsheddingPeriod.create(area: 2, day_of_month: 3, period: 1,
        is_load_shedding1: true,
        is_load_shedding2: false,
        is_load_shedding3: false,
        is_load_shedding4: false)

      LoadsheddingPeriod.create(area: 2, day_of_month: 3, period: 5,
        is_load_shedding1: true,
        is_load_shedding2: false,
        is_load_shedding3: false,
        is_load_shedding4: false)

      LoadsheddingPeriod.create(area: 2, day_of_month: 3, period: 9,
        is_load_shedding1: true,
        is_load_shedding2: false,
        is_load_shedding3: false,
        is_load_shedding4: false)

      get :get_schedule, stage: 'stage1', area: '2', date: '2014-05-03'
      expect(JSON.parse(response.body)).to eq({
        "area_id" => 2,
        "date" => "2014-05-03",
        "day_of_month" => 3,
        "outages" => ["02:00 - 04:30", "10:00 - 12:30", "18:00 - 20:30"],
        "stage" => 1
      })
    end

    it 'errors out if missing stage param' do
      get :get_schedule, area: '2', date: '2014-05-03'
      expect(JSON.parse(response.body)).to eq({"error" => "Missing 'stage' parameter"})
    end

    it 'errors out if missing area param' do
      get :get_schedule, stage: 1, date: '2014-05-03'
      expect(JSON.parse(response.body)).to eq({"error" => "Missing 'area' parameter"})
    end

    it 'errors out if missing date param' do
      get :get_schedule, stage: 1, area: '2'
      expect(JSON.parse(response.body)).to eq({"error" => "Missing 'date' parameter"})
    end

    it 'correctly works out today & tomorrow' do
      LoadsheddingPeriod.create(area: 2, day_of_month: today.day, period: 4,
        is_load_shedding1: true,
        is_load_shedding2: false,
        is_load_shedding3: false,
        is_load_shedding4: false)

      LoadsheddingPeriod.create(area: 2, day_of_month: tomorrow.day, period: 7,
        is_load_shedding1: true,
        is_load_shedding2: false,
        is_load_shedding3: false,
        is_load_shedding4: false)

      get :get_schedule, stage: 'stage1', area: '2', date: 'today'
      expect(JSON.parse(response.body)).to eq({
        "area_id" => 2,
        "date" => today.to_s,
        "day_of_month" => today.day,
        "outages" => ["08:00 - 10:30"],
        "stage" => 1
      })

      get :get_schedule, stage: 'stage1', area: '2', date: 'tomorrow'
      expect(JSON.parse(response.body)).to eq({
        "area_id" => 2,
        "date" => tomorrow.to_s,
        "day_of_month" => tomorrow.day,
        "outages" => ["14:00 - 16:30"],
        "stage" => 1
      })

    end

    it 'errors out if it cant parse date' do
      get :get_schedule, stage: 1, area: '2', date: 'unparseable'
      expect(JSON.parse(response.body)).to eq({"error" => "Badly formatted date: 'unparseable'"})
    end

    it 'errors out if it cant parse stage' do
      get :get_schedule, stage: 'unparseable', area: '2', date: 'today'
      expect(JSON.parse(response.body)).to eq({"error" => "Unknown stage: 'unparseable'"})
    end

    it 'errors out if area out of range' do
      get :get_schedule, stage: 1, area: 20, date: 'today'
      expect(JSON.parse(response.body)).to eq({"error" => "Area number not in range 1-16: 20"})
    end
  end

  describe 'GET get_next_loadshedding' do
    it 'returns correct period in the basic case' do
      LoadsheddingPeriod.create(area: 2, day_of_month: 3, period: 1,
        is_load_shedding1: true,
        is_load_shedding2: false,
        is_load_shedding3: false,
        is_load_shedding4: false)

      LoadsheddingPeriod.create(area: 2, day_of_month: 3, period: 5,
        is_load_shedding1: true,
        is_load_shedding2: false,
        is_load_shedding3: false,
        is_load_shedding4: false)

      LoadsheddingPeriod.create(area: 2, day_of_month: 3, period: 9,
        is_load_shedding1: true,
        is_load_shedding2: false,
        is_load_shedding3: false,
        is_load_shedding4: false)

      Timecop.freeze(Time.new(2015, 1, 3, 0, 0, 0)) do
        get :get_next_loadshedding, area: 2, stage: 1
        expect(JSON.parse(response.body)).to eq({
          "area_id" => 2,
          "next_outage_period" => "02:00 - 04:30",
          "next_outage" => Time.new(2015, 1, 3, 2, 0, 0).iso8601(),
          "stage" => 1
        })
      end

      Timecop.freeze(Time.new(2015, 1, 3, 3, 0, 0)) do
        get :get_next_loadshedding, area: 2, stage: 1
        expect(JSON.parse(response.body)).to eq({
          "area_id" => 2,
          "next_outage_period" => "02:00 - 04:30",
          "next_outage" => Time.new(2015, 1, 3, 2, 0, 0).iso8601(),
          "stage" => 1
        })
      end

      Timecop.freeze(Time.new(2015, 1, 3, 4, 40, 0)) do
        get :get_next_loadshedding, area: 2, stage: 1
        expect(JSON.parse(response.body)).to eq({
          "area_id" => 2,
          "next_outage_period" => "10:00 - 12:30",
          "next_outage" => Time.new(2015, 1, 3, 10, 0, 0).iso8601(),
          "stage" => 1
        })
      end

      Timecop.freeze(Time.new(2015, 1, 3, 23, 40, 0)) do
        get :get_next_loadshedding, area: 2, stage: 1
        expect(JSON.parse(response.body)).to eq({
          "area_id" => 2,
          "next_outage_period" => "02:00 - 04:30",
          "next_outage" => Time.new(2015, 2, 3, 2, 0, 0).iso8601(),
          "stage" => 1
        })
      end
    end
  end

end
