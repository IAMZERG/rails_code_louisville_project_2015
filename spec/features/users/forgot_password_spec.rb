require 'spec_helper'

describe "Forgotten Passwords" do
  let!(:user) {create(:user) }

  it"sends a user an email" do
    visit new_user_session_path
    click_link "Forgot Password"
    fill_in "Email", with: user.email
    expect {
      click_button "Reset Password"
    }.to change { ActionMailer::Base.deliveries.size }.by(1)
  end

  it "resets a password when following the email link" do
    visit new_user_session_path
    click_link "Forgot Password"
    fill_in "Email", with: user.email
    click_button "Reset Password"
    open_email(user.email)
    current_email.click_link "http://"
    expect(page).to have_content("Change Your Password")

    fill_in "Password", with: "oogabooga"
    fill_in "Password (again)", with: "oogabooga"
    click_button "Change Password"
    expect(page).to have_content("Password reset was successful.")
    expect(page.current_path).to eq(decklists_path)
  end
end


