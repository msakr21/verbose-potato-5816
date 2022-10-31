require 'rails_helper'

RSpec.describe "customer show page" do
  before :each do
    @costco = Supermarket.create!(name: "Costco", location: "1234 wherever street")
    @target = Supermarket.create!(name: "Target", location: "1234 whichever street")
    @sally = Customer.create!(name: "Sally")
    @mufasa = Customer.create!(name: "Mufasa")
    @banana = @sally.items.create!(name: "Banana", price: 1, supermarket_id: @costco.id)
    @apple = @sally.items.create!(name: "Apple", price: 2, supermarket_id: @costco.id)
    @cheese = @mufasa.items.create!(name: "Cheese", price: 3, supermarket_id: @target.id)
    @shirt = @mufasa.items.create!(name: "Shirt", price: 18, supermarket_id: @target.id)
    @kiwi =Item.create!(name: "Kiwi", price: 3, supermarket_id: @costco.id)
  end

  it "shows a customer's name and a list of items that include name, price and supermarket they belong to" do
    visit "/customers/#{@sally.id}"

    expect(page).to have_content("Customer: Sally")
    expect(page).to have_content("Items:")
    expect(page).to have_content("Name: Banana, Price: $1, Supermarket: Costco")
    expect(page).to have_content("Name: Apple, Price: $2, Supermarket: Costco")
    expect(page).to_not have_content("Cheese")
    expect(page).to_not have_content("Mufasa")
  end

  it "has a form with a field for item id and a submit button to add an item to customer" do
    visit "/customers/#{@sally.id}"

    expect(page).to_not have_content("Kiwi")
    expect(page).to have_selector(:css, "form")

    fill_in "item_id", with: @kiwi.id
    click_on "Submit"

    expect(current_path).to eql("/customers/#{@sally.id}")
    expect(page).to have_content("Kiwi")
  end
end