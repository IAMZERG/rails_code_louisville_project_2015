class AddPublicAttributeToDecklists < ActiveRecord::Migration
  def change
    add_column :decklists, :public, :boolean
  end
end
