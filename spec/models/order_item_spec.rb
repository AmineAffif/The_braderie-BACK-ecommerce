require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  let(:brand) { Brand.create!(name: 'Test Brand') }
  let(:category) { Category.create!(name: 'Test Category') }
  let(:product) { Product.create!(name: 'Test Product', price: 10.99, brand: brand, category: category) }

  let(:order) do
    Order.create!(
      status: 'processing',
      order_date: Date.today,
      total_price: 15.99
    )
  end

  describe 'associations' do
    it 'belongs to an order' do
      association = described_class.reflect_on_association(:order)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs to a product' do
      association = described_class.reflect_on_association(:product)
      expect(association.macro).to eq :belongs_to
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      order_item = OrderItem.new(order: order, product: product, quantity: 2, price: 20.98)
      expect(order_item).to be_valid
    end

    it 'is not valid without an order' do
      order_item = OrderItem.new(order: nil, product: product, quantity: 2, price: 20.98)
      expect(order_item).not_to be_valid
    end

    it 'is not valid without a product' do
      order_item = OrderItem.new(order: order, product: nil, quantity: 2, price: 20.98)
      expect(order_item).not_to be_valid
    end

    it 'is not valid without a quantity' do
      order_item = OrderItem.new(order: order, product: product, quantity: nil, price: 20.98)
      expect(order_item).not_to be_valid
    end

    it 'is not valid without a price' do
      order_item = OrderItem.new(order: order, product: product, quantity: 2, price: nil)
      expect(order_item).not_to be_valid
    end

  end
end
