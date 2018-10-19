require 'rails_helper'

describe "Beerlist page" do
  before :all do
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :chrome)
    end
    WebMock.disable_net_connect!(allow_localhost: true) 
  end

  before :each do
    @brewery1 = FactoryBot.create(:brewery, name:"Koff")
    @brewery2 = FactoryBot.create(:brewery, name:"Schlenkerla")
    @brewery3 = FactoryBot.create(:brewery, name:"Ayinger")

    @beer1 = FactoryBot.create(:beer, name:"Nikolai", brewery: @brewery1)
    @beer2 = FactoryBot.create(:beer, name:"Fastenbier", brewery:@brewery2)
    @beer3 = FactoryBot.create(:beer, name:"Lechte Weisse", brewery:@brewery3)
  end

  it "shows one known beer", js:true do
    visit beerlist_path
    expect(page).to have_content "Nikolai"
  end

  it "is in alphabetical order", js:true do
    visit beerlist_path
    expect(find('table').find('tr:nth-child(2)')).to have_content "Fastenbier"
    expect(find('table').find('tr:nth-child(3)')).to have_content "Lechte Weisse"
    expect(find('table').find('tr:nth-child(4)')).to have_content "Nikolai"
  end
end