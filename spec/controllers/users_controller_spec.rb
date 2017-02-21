require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  
  describe "POST#create" do
    context "with valid params" do
      it "redirect_to" do
        post :create, user: { username: "username5", password: "password5"}
        expect(response).to redirect_to(user_url(User.find_by_credentials("username5", "password5")))
      end

      it "save new user" do
        post :create, user: { username: "username5", password: "password5"}
        expect(User.find_by_credentials("username5", "password5")).not_to be_nil
      end
    end

    context "with invalid params" do
      it "render back to :new and raise error password can't be blank" do
        post :create, user: {username: "user2"}
        expect(response).to render_template(:new)
        expect(flash[:errors]).to include(/can't be blank/)
      end

      it "render back to :new and raise error for password too short" do
        post :create, user: { username: "user3", password: "asdds"}
        expect(response).to render_template(:new)
        expect(flash[:errors]).to include(/too short/)
      end
    end
  end

end
