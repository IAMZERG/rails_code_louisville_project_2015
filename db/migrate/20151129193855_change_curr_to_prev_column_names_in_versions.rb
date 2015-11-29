class ChangeCurrToPrevColumnNamesInVersions < ActiveRecord::Migration
  def change
    rename_column :versions, :curr_name, :prev_name
    rename_column :versions, :curr_qty, :prev_qty
  end
end
