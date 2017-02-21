
require 'spec_helper'
require 'rails_helper'

feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content("Username")
    expect(page).to have_content("Password")
    expect(current_path).to eq("/users/new")
    expect(page).to have_button("Sign Up!")
  end

  feature "signing up a user" do
    scenario "shows username" do
      sign_up_user("fernanda", "secret")
      expect(page).to have_content("fernanda")
      expect(current_path)
        .to eq("/users/#{User.find_by_credentials("fernanda", "secret").id}")
    end

    scenario "should have a sign out button" do
      sign_up_user("fernanda", "secret")
      expect(page).to have_button("Sign Out")
    end
  end
end

feature "logging in" do
  scenario "shows username" do
    sign_up_user("fernanda", "secret")
    login_user("fernanda", "secret")
    expect(page).to have_content("fernanda")
    expect(current_path)
      .to eq("/users/#{User.find_by_credentials("fernanda", "secret").id}")
  end

  scenario "should have a sign in button" do
    sign_up_user("fernanda", "secret")
    login_user("fernanda", "secret")
    expect(page).to have_button("Sign Out")
  end

end


feature "logging out" do

  scenario "begins with a logged out state" do
    visit new_user_url
    expect(page).to have_content("Sign In")
    expect(page).to have_content("Sign Up")
  end

  scenario "doesn't show username on the homepage after logout" do
    sign_up_user("fernanda", "secret")
    login_user("fernanda", "secret")
    click_on("Sign Out")
    expect(page).not_to have_content("fernanda")
  end

end
