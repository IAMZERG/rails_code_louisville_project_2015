class DecklistCard < ActiveRecord::Base
  belongs_to :decklist
  belongs_to :card
  accepts_nested_attributes_for :card


end
