require 'spec_helper'

describe User do
  let(:valid_attributes) {
    {
      first_name: "Jason",
      last_name: "Seifer",
      email: "jason@teamtreehouse.com",
      password: "password",
      password_confirmation: "password"
    }
  }
  context "relationships" do
    it { should have_many(:decklists) }
  end

  context "validations" do
    let(:user) {User.new(valid_attributes) }
    before do
      User.create(valid_attributes)
    end
    it 'requires user to have an email' do
      expect(user).to validate_presence_of(:email)
    end
    it 'requires a unique email' do
      expect(user).to validate_uniqueness_of(:email)
    end
    it 'downcases email before comparison' do
      user.email = "MIKE@TEAMTREEHOUSE.COM"
      expect(user.save).to be true
      expect(user.email).to eq("mike@teamtreehouse.com")
    end
    it 'requires a unique email (case insensitive)' do
      user.email = "JASON@TEAMTREEHOUSE.COM"
      expect(user).to validate_uniqueness_of(:email)
    end
    it 'requires emails to look like emails' do
      user.email = "jason"
      expect(user).to_not be_valid
    end
  end
  context "#downcase_email" do
    it "makes the email attribute lower case" do
      user = User.new(valid_attributes.merge(email: "JASON@TEAMTREEHOUSE.COM"))
      user.downcase_email
      expect(user.email).to eq("jason@teamtreehouse.com")
    end
  end
end

