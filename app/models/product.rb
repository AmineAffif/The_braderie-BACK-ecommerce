class Product < ApplicationRecord
  belongs_to :brand
  belongs_to :category
  has_many :order_items

  def formatted_price
    sprintf('%.2f', price)
  end
end
