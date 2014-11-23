class CreateRegionUpdates < ActiveRecord::Migration
  def change
    create_table :region_updates do |t|
      t.integer :region_id
      t.boolean :is_load_shedding_active
      t.string  :active_schedule_name
      t.integer :active_schedule_id
      t.timestamps
    end
  end
end
