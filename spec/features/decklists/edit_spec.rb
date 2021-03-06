require 'spec_helper'

describe "Editing decklists" do
  let(:user) { decklist.user }
  let!(:decklist) { create(:decklist) }

  def update_decklist(options={})
    options[:name] ||= "My decklist"
    options[:description] ||= "This is my decklist."
    decklist = options[:decklist]

    visit "/decklists"
    within "#decklist_#{decklist.id}" do
      click_link "Edit"
    end

    fill_in "Decklist Name", with: options[:name]
    fill_in "Description", with: options[:description]
    fill_in "decklist[cards_attributes][4][quantity]", with: 60
    fill_in "decklist[cards_attributes][4][name]", with: "This is a card's name"
    click_button "Update Decklist"
  end

  before do
    sign_in decklist.user, password: "treehouse1"
  end

  it "updates a decklist successfully with correct information" do
    update_decklist decklist: decklist,
      name: "New name",
      description: "New description"

    decklist.reload

    expect(page).to have_content("Decklist was successfully updated")
    expect(decklist.name).to eq("New name")
    expect(decklist.description).to eq("New description")
  end

  it "displays an error with no name" do
    update_decklist decklist: decklist, name: ""
    name = decklist.name
    decklist.reload
    expect(decklist.name).to eq(name)
    expect(page).to have_content("error")
  end

  it "displays an error with too short a name" do
    update_decklist decklist: decklist, name: "hi"
    expect(page).to have_content("error")
  end

  it "displays an error with no description" do
    update_decklist decklist: decklist, description: ""
    expect(page).to have_content("error")
  end

  it "displays an error with too short a description" do
    update_decklist decklist: decklist, description: "hi"
    expect(page).to have_content("error")
  end

  it "displays cards in the deck" do
    update_decklist decklist: decklist
    expect(page).to have_content("This is a card's name")
  end

end
