require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "gets created with correct parameters" do
    brewery = Brewery.create name:"Panimo", year:2017
    beer = Beer.create name:"Bisse", style:"Lager", brewery_id:1

    expect(beer.valid?).to be(true)
    expect(Beer.count).to eq(1)
  end

  it "doesn't get created without a name" do
    brewery = Brewery.create name:"Panimo", year:2017
    beer = Beer.new style:"Lager", brewery_id:1

    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
  end

  it "doesn't get created without a style" do
    brewery = Brewery.create name:"Panimo", year:2017
    beer = Beer.new name:"Bisse", brewery_id:1

    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
  end
end
