require 'rails_helper'

RSpec.describe Supermarket, type: :model do
  describe 'relationships' do
    it { should have_many :items }
  end

  describe 'methods' do
    describe '#unique_customers' do
      it "lists distinctly all customers who bought from the supermarket" do
        costco = Supermarket.create!(name: "Costco", location: "1234 wherever street")
        target = Supermarket.create!(name: "Target", location: "1234 whichever street")

        sally = Customer.create!(name: "Sally")
        mufasa = Customer.create!(name: "Mufasa")
        skar = Customer.create!(name: "Skar")

        banana = sally.items.create!(name: "Banana", price: 1, supermarket_id: costco.id)
        apple = sally.items.create!(name: "Apple", price: 2, supermarket_id: costco.id)
        cheese = mufasa.items.create!(name: "Cheese", price: 3, supermarket_id: target.id)
        shirt = mufasa.items.create!(name: "Shirt", price: 18, supermarket_id: target.id)
        kiwi = Item.create!(name: "Kiwi", price: 3, supermarket_id: costco.id)
        soap = Item.create!(name: "Soap", price: 1, supermarket_id: target.id)

        mufasa.items << soap
        sally.items << soap
        skar.items << kiwi



        expect(Customer.unique_customers(costco.id)).to include(skar, sally)
        expect(Customer.unique_customers(costco.id).length).to eq(2)
      end
    end
  end
end