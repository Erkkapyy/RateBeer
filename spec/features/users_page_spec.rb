require 'rails_helper'

include Helpers

describe "User" do
  before :each do
    FactoryBot.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username: "Pekka", password: "Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username: "Pekka", password: "wrong")
      #save_and_open_page
      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end

    it "has own ratings shown on userpage, and not anyone elses" do
        user2 = FactoryBot.create :user, username:"Äijien Äijä"
        user3 = FactoryBot.create :user, username:"Jokumuu"
        create_beers_with_many_ratings({user: user2}, 10, 20, 15, 7, 9)
        create_beers_with_many_ratings({user: user3}, 5, 39, 21, 1)
        visit user_path(user2)
        
        expect(page).to have_content 'Has made 5 ratings, average rating: 12'
    end

    it "can delete own ratings" do 
        user2 = FactoryBot.create :user, username:"Äijien Äijä"
        create_beers_with_many_ratings({user: user2}, 10, 20, 15, 7, 9)
        sign_in(username: "Äijien Äijä", password: "Foobar1")
        within("li:first-child") do
            click_link "delete"
          end
        expect(page).to have_content 'Has made 4 ratings'
    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with: 'Brian')
    fill_in('user_password', with: 'Secret55')
    fill_in('user_password_confirmation', with: 'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end
end