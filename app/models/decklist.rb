class Decklist < ActiveRecord::Base
  has_many :cards, through: :decklist_cards, source: :card
  has_many :decklist_cards

end

