class CartItem < ApplicationRecord
  belongs_to :user
  belongs_to :product

  def self.add_or_update_cart product_id, user_id
    cart_item = CartItem.where(:product_id => product_id, :user_id => user_id ).first
    if( cart_item.present? )
      cart_item.quantity = cart_item.quantity.to_i + 1
    else
      cart_item = CartItem.new({
        product_id: product_id,
        user_id: user_id,
        quantity: 1
      })
    end
    cart_item
  end
end
