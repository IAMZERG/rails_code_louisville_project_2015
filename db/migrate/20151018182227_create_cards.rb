class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.belongs_to :decklist, index: true
      t.integer :quantity
      t.string :name

      t.timestamps
    end
  end
end
