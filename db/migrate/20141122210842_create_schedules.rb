class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :stage
      t.integer :area
      t.integer :day_of_month

      t.string :outages

      t.timestamps
    end

    add_index :schedules, [:stage, :area, :day_of_month], unique: true, name: 'schd_area_day_index'
  end
end
