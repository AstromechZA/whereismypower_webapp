class AddSourceFieldToUpdates < ActiveRecord::Migration
  def change
    add_column :updates, :source, :string
  end
end
