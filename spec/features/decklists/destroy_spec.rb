require 'spec_helper'

describe "Deleting decklists" do
  let(:user) { decklist.user }
  let!(:decklist) { create(:decklist) }

  before do
    sign_in user, password: "treehouse1"
  end


  it "is successful when clicking the destroy link" do
    visit "/decklists"

    within "#decklist_#{decklist.id}" do
      click_link "Destroy"
    end
    expect(page).to_not have_content(decklist.name)
    expect(Decklist.count).to eq(0)
  end
end
