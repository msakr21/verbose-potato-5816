require 'rails_helper'

RSpec.describe "the items index page" do
  before :each do
    @costco = Supermarket.create!(name: "Costco", location: "1234 wherever street")
    @target = Supermarket.create!(name: "Target", location: "1234 whichever street")

    @sally = Customer.create!(name: "Sally")
    @mufasa = Customer.create!(name: "Mufasa")

    @banana = @sally.items.create!(name: "Banana", price: 1, supermarket_id: @costco.id)
    @apple = @sally.items.create!(name: "Apple", price: 2, supermarket_id: @costco.id)
    @cheese = @mufasa.items.create!(name: "Cheese", price: 3, supermarket_id: @target.id)
    @shirt = @mufasa.items.create!(name: "Shirt", price: 18, supermarket_id: @target.id)
    @kiwi = Item.create!(name: "Kiwi", price: 3, supermarket_id: @costco.id)
    @soap = Item.create!(name: "Soap", price: 1, supermarket_id: @target.id)

    @mufasa.items << @soap
    @sally.items << @soap
  end

  it "lists all items with their names, prices, names of supermarket that they belong to, and count of customers who bought it" do
    visit "/items"
   
    expect(page).to have_content("Item List:")
    expect(page).to have_content("Name: Banana, Price: $1, Supermarket: Costco, Number of times bought: 1")
    expect(page).to have_content("Name: Apple, Price: $2, Supermarket: Costco, Number of times bought: 1")
    expect(page).to have_content("Name: Cheese, Price: $3, Supermarket: Target, Number of times bought: 1")
    expect(page).to have_content("Name: Shirt, Price: $18, Supermarket: Target, Number of times bought: 1")
    expect(page).to have_content("Name: Kiwi, Price: $3, Supermarket: Costco, Number of times bought: 0")
    expect(page).to have_content("Name: Soap, Price: $1, Supermarket: Target, Number of times bought: 2")
  end
end