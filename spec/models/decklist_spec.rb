require 'spec_helper'

describe Decklist do
  it { should have_many(:cards) }
  context "#has_string_for_quantity" do
    let(:decklist) { Decklist.create(
      name: "my awesome deck",
      description: "this is my awesome deck",
      cards_attributes: [
        {
          name: "island",
          quantity: "three"
        },
        {
          name: "swamp",
          quantity: "thirteen"
        }
      ])
    }
    it "throws error(s) when trying to save" do
      decklist.save
      expect(decklist.errors).to_not be_empty
    end
  end
  context "#has_too_short_description" do
    let(:decklist) { Decklist.create(
      name: "my awesome deck",
      description: "dd",
      cards_attributes: [
        {
          name: "island",
          quantity: 3
        },
        {
          name: "swamp",
          quantity: 3
        }
      ])
    }
    it "throws error when trying to save" do
      decklist.save
      expect(decklist.errors).to_not be_empty
    end
  end
  context "#has_non_unique_names?" do
    let(:decklist) { Decklist.create(
      name: "my awesome deck",
      description: "this is my awesome deck",
      cards_attributes: [
        {
          name: "island",
          quantity: 3
        },
        {
          name: "island",
          quantity: 3
        }
      ])
    }
    it "throws error(s) when trying to save" do
      decklist.save
      expect(decklist.errors).to_not be_empty
    end
  end

  context "#has_valid_attributes" do
    let(:decklist) { Decklist.create(
      name: "my awesome deck",
      description: "this is my awesome deck",
      cards_attributes: [
        {
          name: "Island",
          quantity: 3
        },
        {
          name: "Jace",
          quantity: 3
        }
      ])
    }
    it "is saved without error(s)" do
      decklist.save
      expect(decklist.errors).to be_empty
    end
    it "has the correct quantity" do
      expect(decklist.cards[0].quantity).to eq(3)
    end

    it "has the correct total" do
      expect(decklist.total).to eq(6)
    end

    it "correctly updates total with quantity change" do
      decklist.cards[0].quantity = 50
      decklist.save
      expect(decklist.total).to eq(53)
    end
  end
end
