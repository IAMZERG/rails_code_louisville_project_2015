require 'spec_helper'

describe UserSessionsController do
  let!(:user) {
    User.new(
      first_name: "Wes",
      last_name: "Mess",
      email: "wesmess@hotmess.com",
      password: "password",
      password_confirmation: "password"
    )
  }

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
    it "renders the new template" do
      get 'new'
      expect(response).to render_template('new')
    end
  end

  describe "POST 'create'" do
    it "finds the user" do
      expect(User).to receive(:find_by).with({email: "wesmess@hotmess.com"}).and_return(user)
      post :create, email: "wesmess@hotmess.com", password: "password"
    end
    it "redirects to the todo list path" do
      User.stub(:find_by).and_return(user)
      get 'new'
      post :create, email: "wesmess@hotmess.com", password: "password"
      expect(response).to be_redirect
      expect(response).to redirect_to(decklists_path)
    end

    it "authenticates the user" do
      User.stub(:find_by).and_return(user)
      expect(user).to receive(:authenticate)
      post :create, email: "wesmess@hotmess.com", password: "password"
    end
    it "sets the user_id in the session" do
      post :create, email: "wesmess@hotmess.com", password: "password"
      expect(session[:user_id]).to eq(user.id)
    end

    it "sets the flash success message" do
      User.stub(:find_by).and_return(user)
      post :create, email: "wesmess@hotmess.com", password: "password"
      expect(flash[:success]).to eq("Thanks for logging in!")
    end
    shared_examples_for "denied login" do
      it "renders the new template" do
        post :create, email: email, password: password
        expect(response).to render_template('new')
      end

      it "displays error message" do
        post :create, email: email, password: password
        expect(flash[:error]).to eq("There was an error logging in.")
      end
    end
    context "with blank credentials" do
      let(:email) {""}
      let(:password) {""}
      it_behaves_like "denied login"
    end


    context "with incorrect password" do
      let!(:user) {
        User.new(
          first_name: "Wes",
          last_name: "Mess",
          email: "wesmess@hotmess.com",
          password: "password",
          password_confirmation: "password"
        )
      }
      let(:email) {user.email}
      let(:password) {"incorrect!lakjsdf;lka222A"}
      it_behaves_like "denied login"
    end

    context "with no email in existence" do
      let!(:user) {
        User.new(
          first_name: "Wes",
          last_name: "Mess",
          email: "wesmess@hotmess.com",
          password: "password",
          password_confirmation: "password"
        )
      }
      let(:email) {"noone160953408702@nowhere.kham"}
      let(:password) {"'correct'_password"}
      it_behaves_like "denied login"
    end

  end

end
