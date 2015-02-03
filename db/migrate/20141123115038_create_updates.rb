class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.boolean :is_load_shedding_active
      t.integer :stage
      t.timestamps
    end
  end
end
