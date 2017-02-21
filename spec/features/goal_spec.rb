require 'spec_helper'
require 'rails_helper'

feature "creating new goal" do

  feature "when your are not logged in" do
    scenario "redirect to log in page when you try to make new goal" do
      visit new_goal_url
      expect(current_path).to eq "/session/new"
    end
  end

  feature "when your are logged in" do
    before(:each) do
      sign_up_user("aivy","123456")
      @current_id = User.find_by_credentials("aivy", "123456").id
    end

    feature "shows a link to add goal on user show page" do
      scenario "have an Add Goal link" do
        visit user_url(@current_id)
        expect(page).to have_content("Add Goal")
      end
    end

    feature "it shows a form to make new goal" do
      scenario "it has a title" do
        visit new_goal_url
        expect(page).to have_content("Title")
      end
      scenario "it has a description" do
        visit new_goal_url
        expect(page).to have_content("Description")
      end
      scenario "it has a option private" do
        visit new_goal_url
        expect(page).to have_content("private")
        expect(page).to have_content("public")

      end
      scenario "it has a button Add Goal" do
        visit new_goal_url
        expect(page).to have_button("Add Goal")
      end
    end

    feature "with invalid input" do
      scenario "doesn't have a description" do
        visit new_goal_url
        fill_in("Title",with: "Travel")
        select("private", from: "private_options" )
        click_on("Add Goal")
        expect(current_path).to eq("/goals")
        expect(page).to have_content("Description can't be blank")
      end

      scenario "doesn't have a title" do
        visit new_goal_url
        fill_in("Description",with: "travel goals")
        select("private", from: "private_options" )
        click_on("Add Goal")
        expect(current_path).to eq("/goals")
        expect(page).to have_content("Title can't be blank")
      end

    end

    feature "with valid input" do
      scenario "redirect to user show page" do
        add_goal("Travel", "Travel goals", "public")

        expect(current_path).to eq("/users/#{@current_id}")
        expect(page).to have_content("Travel")
      end

      scenario "user page should show all the goals" do
        add_goal("Travel", "Travel goals", "private")
        add_goal("Music", "play ukulele", "public")
        add_goal("Dance", "learn tap dance", "private")

        expect(current_path).to eq("/users/#{@current_id}")
        expect(page).to have_content("Travel")
        expect(page).to have_content("Music")
        expect(page).to have_content("Dance")
      end
    end
  end
end
feature "goal can be private or public" do

  before(:each) do
    sign_up_user("aivy","123456")
    @current_user = User.find_by_credentials("aivy", "123456")
    add_goal("Music", "play ukulele", "public")
    add_goal("Dance", "tap dance", "private")
    add_goal("Travel", "go to Paris", "private")
  end

  feature "when a different user shows a current user show page" do

    scenario "only see public goals" do
      click_on "Sign Out"
      sign_up_user("boo", "123456")
      visit user_url(@current_user)
      expect(page).to have_content("Music")
    end

    scenario "all private goals are hidden" do
      click_on "Sign Out"
      sign_up_user("boo", "123456")
      visit user_url(@current_user)
      expect(page).not_to have_content("Dance")
      expect(page).not_to have_content("Travel")
    end
  end

  feature "when a current user shows their own page" do
    scenario "all private and public goals are shown" do
      visit user_url(@current_user)
      expect(page).to have_content("Music")
      expect(page).to have_content("Dance")
      expect(page).to have_content("Travel")
    end
  end
end
feature "when showing goal/user page" do
  feature "when your are not logged in when you try to view a goal" do
    scenario "redirect to log in page" do
      sign_up_user("boo", "123456")
      click_on "Sign Out"
      visit user_url(User.find_by_credentials("boo", "123456"))
      expect(current_path).to eq "/session/new"
    end
  end
end
