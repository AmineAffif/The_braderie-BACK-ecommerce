class ProductsController < ApplicationController
  def index
    products = Product.all
    render json: products, each_serializer: ProductSerializer

  end

  def show
    product = Product.find(params[:id])
    render json: product, serializer: ProductSerializer
  end
end
