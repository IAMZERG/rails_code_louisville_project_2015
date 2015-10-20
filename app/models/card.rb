class Card < ActiveRecord::Base
  t.has_many :decklists, through: :decklist_cards
end
