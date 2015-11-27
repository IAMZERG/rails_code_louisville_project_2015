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
  context "#paper_trail testing" do
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
    it "adds to versions on update" do
      decklist.update_attributes(name: "My Uber awesome deck!")
      decklist.save
      expect(decklist.versions).to_not be_empty
    end

    it "adds to versions on delete" do
      decklist.destroy
      decklist.save
      expect(decklist.versions).to_not be_empty
    end
    it "adds to versions on create" do
      Decklist.create(name: "another decklist", description: "rawr. im smart")
      decklist.save
      expect(decklist.versions).to_not be_empty
    end
    it "tracks changes to cards" do
      card = decklist.cards.create(name: "Jace, Vryn's Prodigy", quantity: 4)
      decklist.cards.find_by(name: "Jace, Vryn's Prodigy").update_attributes(name: "Brainstorm")
      puts decklist.cards.last.versions.inspect
      puts decklist.cards.inspect
      decklist.save
      expect(card.versions.inspect).to include "Jace, Vryn's Prodigy"
    end
  end
end
