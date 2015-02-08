require 'rails_helper'

RSpec.describe LoadsheddingPeriod, type: :model do

  describe 'month_order' do
    it 'is correct' do
      l = LoadsheddingPeriod.create!(area: 11, day_of_month: 13, period: 4, is_load_shedding1: true, is_load_shedding2: false, is_load_shedding3: true, is_load_shedding4: false)
      expect(l.month_order).to eq(13 * 12 + 4)
    end
  end

  describe 'is_load_shedding?' do
    it 'returns the right attribute' do
      l = LoadsheddingPeriod.new(area: 1, day_of_month: 1, period: 1, is_load_shedding1: true, is_load_shedding2: false, is_load_shedding3: true, is_load_shedding4: false)
      expect(l.is_load_shedding? 1).to be true
      expect(l.is_load_shedding? 2).to be false
      expect(l.is_load_shedding? 3).to be true
      expect(l.is_load_shedding? 4).to be false
      expect { l.is_load_shedding? 0 } .to raise_exception
    end
  end

  describe 'is_area_shedding?' do
    it 'gets correct period in normal conditions' do
      LoadsheddingPeriod.create!(area: 11, day_of_month: 13, period: 4, is_load_shedding1: true, is_load_shedding2: false, is_load_shedding3: true, is_load_shedding4: false)
      expect(LoadsheddingPeriod.is_area_shedding? 11, 1, Time.new(2000, 1, 13, 9, 2, 0)).to be true
    end

    it 'gets correct overlap period if in overlap period' do
      LoadsheddingPeriod.create!(area: 11, day_of_month: 13, period: 4, is_load_shedding1: true, is_load_shedding2: false, is_load_shedding3: true, is_load_shedding4: false)

      expect(LoadsheddingPeriod.is_area_shedding? 11, 1, Time.new(2000, 1, 13, 7, 59, 0)).to be false
      expect(LoadsheddingPeriod.is_area_shedding? 11, 1, Time.new(2000, 1, 13, 9, 31, 0)).to be true
      expect(LoadsheddingPeriod.is_area_shedding? 11, 1, Time.new(2000, 1, 13, 10, 29, 0)).to be true
      expect(LoadsheddingPeriod.is_area_shedding? 11, 1, Time.new(2000, 1, 13, 10, 31, 0)).to be false
    end

    it 'gets correct overlap period after midnight' do
      LoadsheddingPeriod.create!(area: 11, day_of_month: 13, period: 11, is_load_shedding1: true, is_load_shedding2: false, is_load_shedding3: true, is_load_shedding4: false)

      expect(LoadsheddingPeriod.is_area_shedding? 11, 1, Time.new(2000, 1, 13, 21, 59, 0)).to be false
      expect(LoadsheddingPeriod.is_area_shedding? 11, 1, Time.new(2000, 1, 13, 23, 59, 0)).to be true
      expect(LoadsheddingPeriod.is_area_shedding? 11, 1, Time.new(2000, 1, 14, 0, 30, 0)).to be true
      expect(LoadsheddingPeriod.is_area_shedding? 11, 1, Time.new(2000, 1, 14, 0, 31, 0)).to be false
    end

    it 'gets correct overlap period on beginning of month' do
      LoadsheddingPeriod.create!(area: 11, day_of_month: 31, period: 11, is_load_shedding1: true, is_load_shedding2: false, is_load_shedding3: true, is_load_shedding4: false)

      expect(LoadsheddingPeriod.is_area_shedding? 11, 1, Time.new(2000, 2, 1, 0, 29, 0)).to be true
      expect(LoadsheddingPeriod.is_area_shedding? 11, 1, Time.new(2000, 2, 1, 0, 31, 0)).to be false
    end
  end

  describe 'next_loadshed_time' do
    it 'basic' do
      LoadsheddingPeriod.create!(area: 11, day_of_month: 11, period: 3, is_load_shedding1: false, is_load_shedding2: true, is_load_shedding3: false, is_load_shedding4: true)
      LoadsheddingPeriod.create!(area: 11, day_of_month: 11, period: 6, is_load_shedding1: true, is_load_shedding2: false, is_load_shedding3: true, is_load_shedding4: false)

      expect(LoadsheddingPeriod.next_loadshed_time 11, 1, Time.new(2000, 2, 11, 8, 0, 0)).to eq(Time.new(2000, 2, 11, 12, 0, 0))
      expect(LoadsheddingPeriod.next_loadshed_time 11, 1, Time.new(2000, 2, 11, 14, 0, 0)).to eq(Time.new(2000, 3, 11, 6, 0, 0))
      expect(LoadsheddingPeriod.next_loadshed_time 11, 1, Time.new(2000, 12, 11, 14, 0, 0)).to eq(Time.new(2001, 1, 11, 6, 0, 0))
    end
  end

  describe 'areas_shedding' do
    it 'works in the basic case' do
      LoadsheddingPeriod.create!(area: 13, day_of_month: 11, period: 3, is_load_shedding1: false, is_load_shedding2: false, is_load_shedding3: true, is_load_shedding4: false)
      LoadsheddingPeriod.create!(area: 9, day_of_month: 11, period: 3, is_load_shedding1: false, is_load_shedding2: false, is_load_shedding3: false, is_load_shedding4: false)

      expect(LoadsheddingPeriod.areas_shedding 3, Time.new(2000, 2, 11, 6, 10, 0)).to eq([13])
    end

    it 'works in the overlap case' do
      LoadsheddingPeriod.create!(area: 9, day_of_month: 11, period: 2, is_load_shedding1: false, is_load_shedding2: true, is_load_shedding3: true, is_load_shedding4: false)
      LoadsheddingPeriod.create!(area: 13, day_of_month: 11, period: 3, is_load_shedding1: false, is_load_shedding2: true, is_load_shedding3: true, is_load_shedding4: false)

      expect(LoadsheddingPeriod.areas_shedding 2, Time.new(2000, 2, 11, 5, 59, 0)).to eq([9])
      expect(LoadsheddingPeriod.areas_shedding 2, Time.new(2000, 2, 11, 6, 10, 0)).to eq([9, 13])
      expect(LoadsheddingPeriod.areas_shedding 2, Time.new(2000, 2, 11, 6, 31, 0)).to eq([13])
      expect(LoadsheddingPeriod.areas_shedding 2, Time.new(2000, 2, 11, 8, 31, 0)).to eq([])
    end

    it 'works in the month overlap case' do
      LoadsheddingPeriod.create!(area: 1, day_of_month: 31, period: 11, is_load_shedding1: false, is_load_shedding2: true, is_load_shedding3: true, is_load_shedding4: false)
      LoadsheddingPeriod.create!(area: 2, day_of_month: 1, period: 0, is_load_shedding1: false, is_load_shedding2: true, is_load_shedding3: true, is_load_shedding4: false)

      expect(LoadsheddingPeriod.areas_shedding 2, Time.new(2000, 2, 1, 0, 29, 0)).to eq([1, 2])
      expect(LoadsheddingPeriod.areas_shedding 2, Time.new(2000, 2, 1, 0, 31, 0)).to eq([2])
    end

  end

end
