class Card < ActiveRecord::Base
  has_many :decklists, through: :decklist_cards
  has_many :decklist_cards
  accepts_nested_attributes_for :decklist_cards, reject_if: :all_blank, allow_destroy: true


  has_paper_trail :meta => { :curr_name => :name,
  :curr_qty => :quantity
  }
  validates :quantity, numericality: { only_integer: true }

end
