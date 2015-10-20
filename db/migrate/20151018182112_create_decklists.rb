class CreateDecklists < ActiveRecord::Migration
  def change
    create_table :decklists do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
