class AddMonthOrderToLoadsheddingPeriods < ActiveRecord::Migration
  def change
    add_column :loadshedding_periods, :month_order, :integer
  end
end
