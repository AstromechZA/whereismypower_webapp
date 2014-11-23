class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :name
      t.string :long_name, default: ''
      t.boolean :is_load_shedding, default: false
      t.integer :active_schedule_id

      t.timestamps
    end
  end
end
