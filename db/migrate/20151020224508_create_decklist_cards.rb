class CreateDecklistCards < ActiveRecord::Migration
  def change
    create_table :decklist_cards do |t|
      t.belongs_to :decklist
      t.belongs_to :card
      t.quantity :integer
      t.timestamps
    end
  end
end
