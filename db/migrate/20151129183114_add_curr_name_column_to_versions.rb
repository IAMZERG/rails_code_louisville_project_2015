class AddCurrNameColumnToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :curr_name, :string
  end
end
