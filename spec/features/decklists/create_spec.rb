require 'spec_helper'

describe "creating decklists" do
  def create_decklist(options={})
    options[:name] ||= "New decklist"
    options[:description] ||= "this is my new decklist"
    visit "/decklists"
    click_link "New Decklist"
    fill_in 'Name', :with => options[:name]
    fill_in 'Description', :with => options[:description]
    click_button "Create Decklist"
  end
  it "successfully creates decklists with correct information" do

    create_decklist
    expect(page).to have_content "Decklist was successfully created."
  end

  it "redirects to decklist after creation" do
    create_decklist
    expect(page).to have_content "this is my new decklist"
  end

  it "should display error when there is no name" do
    create_decklist(name: "")
    expect(page).to have_content "error"
  end




end


