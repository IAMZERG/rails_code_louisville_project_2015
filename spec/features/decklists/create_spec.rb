require 'spec_helper'

describe "Creating decklists" do
  let(:user) { create(:user) }
  def create_decklist(options={})
    options[:name] ||= "My decklist"
    options[:description] ||= "This is my decklist."

    visit "/decklists"
    expect(page).to have_content("Listing decklists")
    click_link "New Decklist"

    fill_in "Decklist Name", with: options[:name]
    fill_in "Description", with: options[:description]
    click_button "Create Decklist"
  end

  before do
    sign_in(user)
  end

  it "redirects to the decklist index page on success" do
    create_decklist()
    expect(page).to have_content("My decklist")
  end

  it "displays an error when the decklist has no name" do
    expect(Decklist.count).to eq(0)

    create_decklist name: ""

    expect(page).to have_content("error")
    expect(Decklist.count).to eq(0)

    visit "/decklists"
    expect(page).to_not have_content("This is what I'm doing today.")
  end

  it "displays an error when the decklist has a name less than 3 characters" do
    expect(Decklist.count).to eq(0)

    create_decklist name: "Hi"

    expect(page).to have_content("error")
    expect(Decklist.count).to eq(0)

    visit "/decklists"
    expect(page).to_not have_content("This is what I'm doing today.")
  end

  it "displays an error when the decklist has no description" do
    expect(Decklist.count).to eq(0)

    create_decklist name: "Grocery list", description: ""

    expect(page).to have_content("error")
    expect(Decklist.count).to eq(0)

    visit "/decklists"
    expect(page).to_not have_content("Grocery list")
  end

end
