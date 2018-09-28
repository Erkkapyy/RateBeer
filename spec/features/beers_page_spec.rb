require 'rails_helper'
include Helpers

describe "Beers page" do

  before :each do
    FactoryBot.create :user
    sign_in(username: "Pekka", password: "Foobar1")
  end
  
  it "can create beer with proper name" do
    brewery = Brewery.create name:"Koff", year:1908
    create_beer(name: "Uusiolut")
    expect(page).to have_content 'Beer was successfully created.'
    expect(Beer.count).to eq(1)
  end

  it "can't create beer without name" do
    brewery = Brewery.create name:"Koff", year:1908
    create_beer(name: "")
    #save_and_open_page
    expect(page).to have_content "Name can't be blank"
    expect(Beer.count).to eq(0)
  end

end