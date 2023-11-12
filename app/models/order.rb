class Order < ApplicationRecord
  has_many :order_items

  validates :total_price, :status, :order_date, presence: true

  accepts_nested_attributes_for :order_items
end
  