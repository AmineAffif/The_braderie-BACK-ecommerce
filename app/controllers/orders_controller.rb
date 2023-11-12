class OrdersController < ApplicationController
  def create
    ActiveRecord::Base.transaction do
      order = Order.new(order_params)
  
      order.order_items.each do |item|
        product = Product.find(item.product_id)
        raise ActiveRecord::Rollback if item.quantity > product.inventory
      end
  
      if order.save
        order.order_items.each do |item|
          product = Product.find(item.product_id)
          product.update!(inventory: product.inventory - item.quantity)
        end
  
        render json: order, status: :created
      else
        render json: order.errors, status: :unprocessable_entity
      end
    end
  end

  private

  def order_params
    params.require(:order).permit(:total_price, :status, :order_date, order_items_attributes: [:product_id, :quantity, :price])
  end
end
