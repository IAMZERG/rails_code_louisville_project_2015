require "spec_helper"

describe "Logging in" do
  it "displays the email address in the event of a failed login" do
    visit new_user_session_path
    fill_in "Email Address", with: "jason@teamtreehouse.com"
    fill_in "Password", with: "incorrect"
    click_button "Log In"
    expect(page).to have_content("There was an error logging in.")
    expect(page).to have_field("Email", with: "jason@teamtreehouse.com")
  end

  it "logs the user in and goes to the decklists" do
    User.create(first_name: "Wes", last_name: "Mess", email: "wesmess@hotmess.com",
                password: "password", password_confirmation: "password")
    visit new_user_session_path
    fill_in "Email Address", with: "wesmess@hotmess.com"
    fill_in "Password", with: "password"
    click_button "Log In"
    expect(page).to have_content("Decklists")
    expect(page).to have_content("Thanks for logging in!")
  end
end
