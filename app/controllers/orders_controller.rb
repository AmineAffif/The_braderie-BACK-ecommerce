class OrdersController < ApplicationController
  def create
    order = Order.new(order_params)
    if order.save
      render json: order, status: :created
    else
      render json: order.errors, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(:total_price, :status, :order_date, order_items_attributes: [:product_id, :quantity, :price])
  end
end
