class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :name
      t.string :long_name, default: ''

      t.integer :region_id

      t.timestamps
    end
  end
end
