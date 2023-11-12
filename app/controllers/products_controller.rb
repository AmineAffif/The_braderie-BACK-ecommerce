class ProductsController < ApplicationController
  def index
    per_page = 21
    page = params[:page].present? ? params[:page].to_i : 1
    products = Product.includes(:brand, :category).page(page).per(per_page)
    total_pages = (Product.count.to_f / per_page).ceil

    # Sérialisation avec ProductSerializer
    serialized_products = ActiveModel::SerializableResource.new(products, each_serializer: ProductSerializer)

    render json: { products: serialized_products, total_pages: total_pages }
  end

  def show
    product = Product.find(params[:id])
    render json: product, serializer: ProductSerializer
  end
end
