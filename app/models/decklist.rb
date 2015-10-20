class Decklist < ActiveRecord::Base
  t.has_many :cards, through: :decklist_cards
end
