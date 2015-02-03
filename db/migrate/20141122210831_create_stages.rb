class CreateStages < ActiveRecord::Migration
  def change
    create_table :stages do |t|
      t.integer :code, unique: true
      t.string :name, unique: true
      t.string :description

      t.timestamps
    end

    add_index :stages, [:code]
  end
end
