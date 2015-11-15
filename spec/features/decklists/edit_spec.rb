require 'spec_helper'

describe 'editing decklists' do
  def create_decklist(options={})
    options[:name] ||= "New decklist"
    options[:description] ||= "this is my new decklist"
    visit "/decklists"
    click_link "New Decklist"
    fill_in 'Name', :with => options[:name]
    fill_in 'Description', :with => options[:description]
    click_button "Create Decklist"
  end

  def add_cards(options={})
    options[:decklist] ||= Decklist.create(name: "Islands", description: "MARO plz nerf.")
    options[:cards] ||= [{name: "Island", quantity: 60}]
    options[:cards].each do |card|
      options[:decklist].cards.create(name: card[:name], quantity: card[:quantity])
    end
    return options[:decklist]
  end

  it "displays the cards in each decklist" do
    create_decklist
    decklist = add_cards
    visit(edit_decklist_path(decklist))
    expect(page).to have_content "Island"
    expect(page).to have_content "MARO plz nerf."
    expect(page).to have_content "60"
  end

end
