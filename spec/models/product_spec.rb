require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:brand) { Brand.create!(name: 'Test Brand') }
  let(:category) { Category.create!(name: 'Test Category') }

  describe 'associations' do
    it 'belongs to a brand' do
      association = described_class.reflect_on_association(:brand)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs to a category' do
      association = described_class.reflect_on_association(:category)
      expect(association.macro).to eq :belongs_to
    end

    it 'has many order items' do
      association = described_class.reflect_on_association(:order_items)
      expect(association.macro).to eq :has_many
    end
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      product = Product.new(name: 'Test Product', price: 10.99, brand: brand, category: category)
      expect(product).to be_valid
    end

    it 'is not valid without a name' do
      product = Product.new(name: nil, price: 10.99, brand: brand, category: category)
      expect(product).not_to be_valid
    end

    it 'is not valid without a price' do
      product = Product.new(name: 'Test Product', price: nil, brand: brand, category: category)
      expect(product).not_to be_valid
    end

    it 'is not valid without a brand' do
      product = Product.new(name: 'Test Product', price: 10.99, brand: nil, category: category)
      expect(product).not_to be_valid
    end

    it 'is not valid without a category' do
      product = Product.new(name: 'Test Product', price: 10.99, brand: brand, category: nil)
      expect(product).not_to be_valid
    end

  end
end
