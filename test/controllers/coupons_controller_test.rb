require "test_helper"

class CouponsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @coupon = coupons(:one)
  end

  test "should get index" do
    get coupons_url, as: :json
    assert_response :success
  end

  test "should create coupon" do
    assert_difference("Coupon.count") do
      post coupons_url, params: { coupon: { coupon_code: @coupon.coupon_code, discount: @coupon.discount, discount_type: @coupon.discount_type, expiry_date: @coupon.expiry_date, max_amount: @coupon.max_amount, max_count: @coupon.max_count, min_amount: @coupon.min_amount, status: @coupon.status } }, as: :json
    end

    assert_response :created
  end

  test "should show coupon" do
    get coupon_url(@coupon), as: :json
    assert_response :success
  end

  test "should update coupon" do
    patch coupon_url(@coupon), params: { coupon: { coupon_code: @coupon.coupon_code, discount: @coupon.discount, discount_type: @coupon.discount_type, expiry_date: @coupon.expiry_date, max_amount: @coupon.max_amount, max_count: @coupon.max_count, min_amount: @coupon.min_amount, status: @coupon.status } }, as: :json
    assert_response :success
  end

  test "should destroy coupon" do
    assert_difference("Coupon.count", -1) do
      delete coupon_url(@coupon), as: :json
    end

    assert_response :no_content
  end
end
