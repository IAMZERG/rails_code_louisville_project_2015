require 'spec_helper'

describe "Creating todo lists" do
  it "redirects to the index page" do
    visit "/decklists"
    click_link "New Decklist"
    expect(page).to have_content "New decklist"
  end
end
