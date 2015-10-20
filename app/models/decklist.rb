class Decklist < ActiveRecord::Base
  has_many :cards
end
