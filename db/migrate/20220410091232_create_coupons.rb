class CreateCoupons < ActiveRecord::Migration[7.0]
  def change
    create_table :coupons do |t|
      t.string :coupon_code
      t.date :expiry_date
      t.integer :max_count
      t.decimal :max_amount
      t.integer :status
      t.integer :discount_type
      t.decimal :min_amount
      t.decimal :discount

      t.timestamps
    end
  end
end
