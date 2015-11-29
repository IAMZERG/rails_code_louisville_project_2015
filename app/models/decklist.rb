class Decklist < ActiveRecord::Base
  has_many :cards, through: :decklist_cards, source: :card
  has_many :decklist_cards
  belongs_to :user
  accepts_nested_attributes_for :cards, reject_if: :all_blank, allow_destroy: true
  validates :description, presence: true,
    length: { minimum: 3 }
  validates :name, presence: true,
    length: { minimum: 3 }

  validate :card_names_are_unique_for_decklist

  has_paper_trail

  before_save :reset_total

  def total
    @total ||= self.cards.to_a.sum {|c| c.quantity }
  end

  def reset_total
    @total = nil
  end

  def changes
    versions = []
    self.cards.each do |card|
      card.versions.each do |version|
        versions.append(version)
      end
    end
    versions = versions.group_by { |version| version.transaction_id }
    return versions
  end

  private
  def card_names_are_unique_for_decklist
    self.cards.each do |card|
      if self.cards.each.find_all { |c| c.name == card.name }.length > 1
        errors.add(:name, "Cards in deck must be unique")
      end
    end
    true
  end

end
