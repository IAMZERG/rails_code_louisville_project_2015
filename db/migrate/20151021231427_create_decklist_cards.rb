class CreateDecklistCards < ActiveRecord::Migration
  def change
    create_table :decklist_cards do |t|
      t.belongs_to :decklist, index: true
      t.belongs_to :card, index: true
      t.integer :quantity
      t.timestamps
    end
  end
end
