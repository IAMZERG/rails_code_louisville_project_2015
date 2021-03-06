class Card < ActiveRecord::Base
  has_many :decklists, through: :decklist_cards
  has_many :decklist_cards
  accepts_nested_attributes_for :decklist_cards, reject_if: :all_blank, allow_destroy: true


  has_paper_trail :meta => { :prev_name => :name,
  :prev_qty => :quantity
  }
  validates :quantity, numericality: { only_integer: true }

end
