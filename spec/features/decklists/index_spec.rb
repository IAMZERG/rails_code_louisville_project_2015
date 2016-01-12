require 'spec_helper'


# to-do list:
# Get all the tests passing regarding the public attribute on decklists
# # modify the decklists view so that it accomodates the new attribute
# #add section to decklists view so that it shows 'Log in to see your decklists.'

describe "Listing decklists" do
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
  def create_user_and_log_in
    User.create(first_name: "Wes", last_name: "Mess", email: "wesmess@hotmess.com",
                password: "password", password_confirmation: "password")
    visit new_user_sessions_path
    fill_in "Email Address", with: "wesmess@hotmess.com"
    fill_in "Password", with: "password"
    click_button "Log In"
    expect(page).to have_content("Decklists")
    expect(page).to have_content("Thanks for logging in!")
  end
  it "requires login to show private decklists" do
    visit "/decklists"
    expect(page).to have_content("Log in to see your decklists.")
  end

  it "shows public decklists when not logged in" do
    Decklist.new(name: "cool_deck", description: "Rawr.  I'm the best.", public: true)
    visit "/decklists"
    expect(page).to have_content("Rawr.  I'm the best.")
  end


  it "shows a user's decklists when logged in" do
    create_user_and_log_in
    create_decklist
    expect(page).to have_content("This is my decklist.")
  end
end
