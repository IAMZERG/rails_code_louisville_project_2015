class Card < ActiveRecord::Base
  has_many :decklists, through: :decklist_cards
  has_many :decklist_cards
end
