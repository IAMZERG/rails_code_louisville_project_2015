class DecklistCard < ActiveRecord::Base
  belongs_to :decklist
  belongs_to :card
end
