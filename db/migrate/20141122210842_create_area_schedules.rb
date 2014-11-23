class CreateAreaSchedules < ActiveRecord::Migration
  def change
    create_table :area_schedules do |t|
      t.integer :schedule_id
      t.integer :area_id

      t.string :monday_outtages
      t.string :tuesday_outtages
      t.string :wednesday_outtages
      t.string :thursday_outtages
      t.string :friday_outtages
      t.string :saturday_outtages
      t.string :sunday_outtages

      t.timestamps
    end
  end
end
