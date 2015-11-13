class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.belongs_to :decklist, index: true
      t.string :name
      t.integer :quantity
      t.timestamps
    end
  end
end
