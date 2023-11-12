class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, :price, presence: true
  validate :product_quantity_available

  private

  def product_quantity_available
    return if product.nil? || quantity.nil?

    if quantity > product.inventory
      errors.add(:quantity, 'exceeds available stock')
    end
  end

end
