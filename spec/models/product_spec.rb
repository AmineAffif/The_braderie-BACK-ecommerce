require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'is valid with valid attributes' do
    brand = Brand.create(name: 'Test Brand')
    category = Category.create(name: 'Test Category')
    product = Product.new(name: 'Test Product', price: 10.99, inventory: 15, brand: brand, category: category)
    expect(product).to be_valid
  end

  it 'is not valid without a name' do
    product = Product.new(name: nil)
    expect(product).not_to be_valid
  end

end
