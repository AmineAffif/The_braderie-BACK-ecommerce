class Product < ApplicationRecord
  belongs_to :brand
  belongs_to :category
  has_many :order_items

  validates :name, :price, presence: true
  validates :price, numericality: { greater_than: 0 }

  def formatted_price
    sprintf('%.2f', price)
  end
end
