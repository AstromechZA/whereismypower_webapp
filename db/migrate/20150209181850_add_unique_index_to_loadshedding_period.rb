class AddUniqueIndexToLoadsheddingPeriod < ActiveRecord::Migration
  def change
    add_index :loadshedding_periods, [:area, :day_of_month, :period], unique: true, name: 'adp_index'
  end
end
