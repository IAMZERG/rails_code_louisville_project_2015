require 'spec_helper'


# to-do list:
# # modify the decklists view so that it accomodates the new attribute
# it should not show "Edit" or "Delete" as options when not logged in.

describe "Listing decklists" do
  def create_decklist(options={})
    options[:name] ||= "My decklist"
    options[:description] ||= "This is my decklist."
    options[:public] ||= false

    visit "/decklists"
    expect(page).to have_content("Listing decklists")
    click_link "New Decklist"

    fill_in "Decklist Name", with: options[:name]
    fill_in "Description", with: options[:description]
    click_button "Create Decklist"
  end
  def create_user_and_log_in
    user = User.create(first_name: "Wes", last_name: "Mess", email: "wesmess@hotmess.com",
                password: "password", password_confirmation: "password")
    visit new_user_sessions_path
    fill_in "Email Address", with: "wesmess@hotmess.com"
    fill_in "Password", with: "password"
    click_button "Log In"
    expect(page).to have_content("Decklists")
    expect(page).to have_content("Thanks for logging in!")
    return user
  end
  it "requires login to show private decklists" do
    visit "/decklists"
    expect(page).to have_content("Log in to view your decklists")
  end

  it "shows public decklists when not logged in" do
    create_user_and_log_in
    create_decklist({public: true, description: "Rawr.  I'm the best.", name: "cool_deck"})
    visit "/decklists"
    expect(page).to have_content("Rawr.  I'm the best.")
  end

  it "does not show edit or delete options when not logged in" do
    user = create_user_and_log_in
    decklist = create_decklist
    click_link("Log Out")
    visit "/decklists"
    expect(page).to_not have_content("Edit")
    expect(page).to_not have_content("Delete")
  end

  it "shows edit and delete options when logged in" do
    create_user_and_log_in
    create_decklist
    visit "/decklists"
    expect(page).to have_content("Edit")
    expect(page).to have_content("Destroy")
  end

  it "shows a user's decklists when logged in" do
    create_user_and_log_in
    create_decklist
    expect(page).to have_content("This is my decklist.")
  end
end
