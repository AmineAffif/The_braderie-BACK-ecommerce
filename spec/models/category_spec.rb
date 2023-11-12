require 'rails_helper'

RSpec.describe Category, type: :model do
  it 'is valid with a name' do
    category = Category.new(name: 'Electronics')
    expect(category).to be_valid
  end

  it 'is not valid without a name' do
    category = Category.new(name: nil)
    expect(category).not_to be_valid
  end
end
