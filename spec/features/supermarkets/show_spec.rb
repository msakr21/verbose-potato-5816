require 'rails_helper'

RSpec.describe "supermarket show page" do
  before :each do
    @costco = Supermarket.create!(name: "Costco", location: "1234 wherever street")
    @target = Supermarket.create!(name: "Target", location: "1234 whichever street")

    @sally = Customer.create!(name: "Sally")
    @mufasa = Customer.create!(name: "Mufasa")
    @skar = Customer.create!(name: "Skar")

    @banana = @sally.items.create!(name: "Banana", price: 1, supermarket_id: @costco.id)
    @apple = @sally.items.create!(name: "Apple", price: 2, supermarket_id: @costco.id)
    @cheese = @mufasa.items.create!(name: "Cheese", price: 3, supermarket_id: @target.id)
    @shirt = @mufasa.items.create!(name: "Shirt", price: 18, supermarket_id: @target.id)
    @kiwi =Item.create!(name: "Kiwi", price: 3, supermarket_id: @costco.id)
    @soap = Item.create!(name: "Soap", price: 1, supermarket_id: @target.id)

    @mufasa.items << @soap
    @sally.items << @soap
    @skar.items << @kiwi
  end

  it "shows a customer's name and a list of items that include name, price and supermarket they belong to" do
    visit "/supermarkets/#{@costco.id}"
   
    expect(page).to have_content("Supermarket: Costco")
    expect(page).to have_content("Customers:")
    expect(page).to have_content("Skar")
    expect(page).to have_content("Sally")
  end
end