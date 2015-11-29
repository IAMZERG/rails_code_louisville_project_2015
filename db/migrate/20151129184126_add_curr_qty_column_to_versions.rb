class AddCurrQtyColumnToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :curr_qty, :integer
  end
end
