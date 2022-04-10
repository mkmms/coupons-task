# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
  has_many :cart_items
  has_many :products, through: :cart_items

  has_many :coupon_transactions
  has_many :coupons, through: :coupon_transactions

  has_many :orders

  enum roles: {
    admin: 1,
    user: 2
  }

  def get_cart_items
    products.joins(:cart_items).select("cart_items.id as id, name, price, cart_items.quantity as quantity, img, price * cart_items.quantity as total")
  end

  def get_cart_total
    total = products.joins(:cart_items).select("sum(price * cart_items.quantity) as total")
    total.present? ? total[0][:total] : 0
  end

  def net_cart_amount
    get_cart_total + (get_cart_total * 5/100)
  end

  def confirm_order params
    Order.transaction do
      if params[:is_applied].present?
        coupon = Coupon.where(coupon_code: params[:coupon_code]).first
        coupon.coupon_transactions.create(discount_amount: params[:amount].to_f, user_id: self.id)
      end
      order = orders.create(amount: net_cart_amount - params[:amount].to_f)
      cart_items.destroy_all
      order.save
    end
  end
end
