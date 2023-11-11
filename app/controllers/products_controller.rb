class ProductsController < ApplicationController
  def index
    per_page = 21
    page = params[:page].present? ? params[:page].to_i : 1
    products = Product.page(page).per(per_page)
    total_pages = (Product.count.to_f / per_page).ceil

    render json: { products: products, total_pages: total_pages }
  end

  def show
    product = Product.find(params[:id])
    render json: product, serializer: ProductSerializer
  end
end
