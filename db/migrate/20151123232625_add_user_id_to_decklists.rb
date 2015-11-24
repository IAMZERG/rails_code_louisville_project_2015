class AddUserIdToDecklists < ActiveRecord::Migration
  def change
    add_column :decklists, :user_id, :integer
    add_index :decklists, :user_id
  end
end
