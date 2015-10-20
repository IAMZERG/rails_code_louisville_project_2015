class AddColumsToDecklistAndCards < ActiveRecord::Migration
  def change
    change_table :card do |t|
      t.integer :decklist_id
    end
    change_table :decklist do |t|
      t.integer :card_id
    end
  end
end
