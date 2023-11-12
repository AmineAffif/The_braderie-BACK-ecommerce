require 'rails_helper'

RSpec.describe Brand, type: :model do
  it 'is valid with a name' do
    brand = Brand.new(name: 'Test Brand')
    expect(brand).to be_valid
  end

  it 'is not valid without a name' do
    brand = Brand.new(name: nil)
    expect(brand).not_to be_valid
  end

end
