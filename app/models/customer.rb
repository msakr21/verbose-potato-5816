class Customer < ApplicationRecord
  has_many :customer_items
  has_many :items, through: :customer_items

  def self.unique_customers(id)
    # binding.pry
    joins("INNER JOIN customer_items ON customer_items.customer_id = customers.id").joins("INNER JOIN items on customer_items.item_id = items.id").distinct.where("supermarket_id = ?", id)
  end
end