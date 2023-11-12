require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe 'POST create' do
    context 'with valid parameters' do
      let!(:brand) { Brand.create!(name: 'Test Brand') }
      let!(:category) { Category.create!(name: 'Test Category') }
      let!(:product) { Product.create!(name: 'Test Product', price: 10.99, brand: brand, category: category) }

      let(:valid_attributes) do
        {
          order: {
            total_price: 100.0,
            status: 'processing',
            order_date: Date.today,
            order_items_attributes: [
              {
                product_id: product.id,
                quantity: 2,
                price: product.price
              }
            ]
          }
        }
      end

      it 'creates a new order' do
        expect {
          post :create, params: valid_attributes
        }.to change(Order, :count).by(1)
      end

      it 'returns a created status' do
        post :create, params: valid_attributes
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        {
          order: {
            total_price: nil,
            status: 'processing',
            order_date: Date.today
            # missing order_items_attributes
          }
        }
      end

      it 'does not create a new order' do
        expect {
          post :create, params: invalid_attributes
        }.to change(Order, :count).by(0)
      end

      it 'returns an unprocessable entity status' do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
