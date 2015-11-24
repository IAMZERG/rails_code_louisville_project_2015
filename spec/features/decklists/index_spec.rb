require 'spec_helper'

describe "Listing todo lists" do
  it "requires login" do
    visit "/decklists"
    expect(page).to have_content("You must be logged in")
  end
end
