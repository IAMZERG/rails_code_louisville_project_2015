class Card < ActiveRecord::Base
  has_many :decklists, through: :decklist_cards
  has_many :decklist_cards
  accepts_nested_attributes_for :decklist_cards


  validates :quantity, numericality: { only_integer: true }


end
