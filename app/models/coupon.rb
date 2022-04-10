class Coupon < ApplicationRecord
  acts_as_paranoid
  before_destroy :can_destroy?, prepend: true

  has_many :coupon_transactions
  has_many :users, through: :coupon_transactions

  validates_uniqueness_of :coupon_code
  validates_presence_of [:expiry_date, :max_count, :max_amount, :status, :discount_type, :min_amount, :discount]

  scope :active_coupons, -> { where(status: Coupon.statuses[:active]) }

  enum status: {
    active: 1,
    inactive: 2
  }

  enum discount_type: {
    flat: 1,
    percent: 2
  }

  def is_expired?
    expiry_date < Date.today
  end

  def is_applicable? amount, user_id
    !is_expired? && min_amount <= amount && active? && max_count > used_count(user_id)
  end

  def used_count user_id
    coupon_transactions.where(user_id: user_id).count
  end

  def calculate_the_discount amount
    discounted_amt = flat? ? discount : amount * discount / 100
    return max_amount > discounted_amt ? discounted_amt : max_amount
  end

  def change_status
    update!(status: active? ? Coupon.statuses[:inactive] : Coupon.statuses[:active])
  end

  def self.apply_coupon coupon_code, user
    coupon = Coupon.where(coupon_code: coupon_code).first
    total = user.get_cart_total
    response = {}
    if coupon.is_applicable? total, user
      response[:amount] = coupon.calculate_the_discount total
      response[:coupon_code] = coupon.coupon_code
      response[:is_applied] = true
    else
      response[:is_applied] = false
    end
    response
  end

  private
  def can_destroy?
    if active?
      self.errors.add(:base, "Can't be destroy coupon with active status")
      throw :abort
    end
  end
end
