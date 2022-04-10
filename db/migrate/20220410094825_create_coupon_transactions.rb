class CreateCouponTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :coupon_transactions do |t|
      t.decimal :discount_amount
      t.belongs_to :coupon, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
