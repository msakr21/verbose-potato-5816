require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :supermarket }
    it { should have_many :customer_items }
    it { should have_many(:customers).through :customer_items }
  end

  describe 'methods' do
    describe '#customer_count' do
      it "counts number of customers who have bought an item" do
        costco = Supermarket.create!(name: "Costco", location: "1234 wherever street")
        target = Supermarket.create!(name: "Target", location: "1234 whichever street")

        sally = Customer.create!(name: "Sally")
        mufasa = Customer.create!(name: "Mufasa")

        banana = sally.items.create!(name: "Banana", price: 1, supermarket_id: costco.id)
        apple = sally.items.create!(name: "Apple", price: 2, supermarket_id: costco.id)
        cheese = mufasa.items.create!(name: "Cheese", price: 3, supermarket_id: target.id)
        shirt = mufasa.items.create!(name: "Shirt", price: 18, supermarket_id: target.id)
        kiwi = Item.create!(name: "Kiwi", price: 3, supermarket_id: costco.id)
        soap = Item.create!(name: "Soap", price: 1, supermarket_id: target.id)

        mufasa.items << soap
        sally.items << soap

        expect(kiwi.customer_count).to eq(0)
        expect(soap.customer_count).to eq(2)
        expect(banana.customer_count).to eq(1)
      end
    end
  end
end
