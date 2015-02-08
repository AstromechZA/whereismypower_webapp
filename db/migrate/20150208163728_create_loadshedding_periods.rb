class CreateLoadsheddingPeriods < ActiveRecord::Migration
  def change
    create_table :loadshedding_periods do |t|
      t.integer :area
      t.integer :day_of_month
      t.integer :period
      t.boolean :is_load_shedding1
      t.boolean :is_load_shedding2
      t.boolean :is_load_shedding3
      t.boolean :is_load_shedding4
    end
  end
end
