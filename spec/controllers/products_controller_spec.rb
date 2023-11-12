require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe 'GET index' do
    before do
      Product.create(name: 'Test Product', price: 10.99)
    end

    it 'returns a successful response' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'returns a list of products' do
      get :index
      json_response = JSON.parse(response.body)
      expect(json_response['products']).not_to be_empty
    end
  end

  describe 'GET show' do
    let!(:brand) { Brand.create!(name: 'Test Brand') }
    let!(:category) { Category.create!(name: 'Test Category') }
    let!(:product) { Product.create!(name: 'Test Product', price: 10.99, brand: brand, category: category) }

    it 'returns a successful response' do
      get :show, params: { id: product.id }
      expect(response).to have_http_status(:success)
    end

    it 'returns the requested product' do
      get :show, params: { id: product.id }
      json_response = JSON.parse(response.body)
      expect(json_response['id']).to eq(product.id)
    end
  end


  
  
end
