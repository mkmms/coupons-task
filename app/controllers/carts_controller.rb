class CartsController < ApplicationController
  before_action :authenticate_user!

  def index
    products = current_user.get_cart_items

    render json: { products: products }
  end

  def create
    cart_item = CartItem.add_or_update_cart(params[:id], current_user.id)
    if cart_item.save
      render json: cart_item, status: :created, location: "/carts"
    else
      render json: cart_item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    cart_item = CartItem.where(id: params[:id]).first
    cart_item.destroy
    render json: cart_item.id, status: :ok
  end

  def confirm_order
    current_user.confirm_order params
    
    render json: "ok", status: :ok
  end
end