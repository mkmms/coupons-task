# frozen_string_literal: true

User.first_or_create({
                       name: 'Admin',
                       email: 'admin@gmail.com',
                       role: User.roles[:admin],
                       password: 'Admin@123',
                       password_confirmation: 'Admin@123'
                     })

products = [
  {
    img: "https://images.unsplash.com/photo-1523275335684-37898b6baf30?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1399&q=80",
    name: "Smart Watch",
    price: 3499
  },
  {
    img: "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
    name: "Head Phone",
    price: 1999
  },
  {
    img: "https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1467&q=80",
    name: "Mouse",
    price: 149
  },
  {
    img: "https://images.unsplash.com/photo-1545289414-1c3cb1c06238?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
    name: "Nike",
    price: 2999
  }
]

products.each do |product|
  product_property_attrs  = { 
    name: product[:name], 
    img: product[:img], 
    price: product[:price] 
  }
  Product.where(product_property_attrs).first_or_create
end

coupons = [
  {
    coupon_code: "FLAT100",
    expiry_date: "2022-05-10",
    max_count: 3,
    max_amount: 100,
    min_amount: 3000,
    discount: 100,
    status: Coupon.statuses[:active],
    discount_type: Coupon.discount_type[:flat],
  },
  {
    coupon_code: "10PERCENT",
    expiry_date: "2022-05-10",
    max_count: 3,
    max_amount: 200,
    min_amount: 3000,
    discount: 10,
    status: Coupon.statuses[:active],
    discount_type: Coupon.discount_type[:percent],
  }
]

coupons.each do |coupon|
  Coupon.where(coupon).first_or_create
end