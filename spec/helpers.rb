module Helpers

    def create_beer_with_rating(object, score)
        beer = FactoryBot.create(:beer)
        FactoryBot.create(:rating, beer: beer, score: score, user: object[:user] )
        beer
    end

    def create_beers_with_many_ratings(object, *scores)
        scores.each do |score|
          create_beer_with_rating(object, score)
        end
    end

    def sign_in(credentials)
      visit signin_path
      fill_in('username', with:credentials[:username])
      fill_in('password', with:credentials[:password])
      click_button('Log in')
    end

    def create_beer(beer)
        visit new_beer_path
        fill_in('Name', with:beer[:name])
        click_button('Create Beer')
      end
  end