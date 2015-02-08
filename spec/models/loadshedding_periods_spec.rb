require 'rails_helper'

RSpec.describe LoadsheddingPeriod, type: :model do

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
end
