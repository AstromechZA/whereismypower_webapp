class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.integer :code, unique: true
      t.string :name, unique: true
      t.string :long_name, default: ''

      t.timestamps
    end

    add_index :areas, [:code]
  end
end
