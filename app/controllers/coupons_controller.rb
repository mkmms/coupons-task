class CouponsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_coupon, only: %i[ show update destroy update_status ]

  # GET /coupons
  def index
    @coupons = Coupon.all

    render json: @coupons
  end

  # GET /coupons/1
  def show
    render json: @coupon
  end

  # POST /coupons
  def create
    @coupon = Coupon.new(coupon_params)

    if @coupon.save
      render json: @coupon, status: :created, location: @coupon
    else
      render json: @coupon.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /coupons/1
  def update
    if @coupon.update(coupon_params)
      render json: @coupon
    else
      render json: @coupon.errors, status: :unprocessable_entity
    end
  end

  # DELETE /coupons/1
  def destroy
    @coupon.destroy
  end

  def update_status
    @coupon.change_status

    render json: @coupon, status: :ok
  end

  def apply
    response = Coupon.apply_coupon params[:coupon_code], current_user
    if response[:is_applied]
      render json: response, status: :ok
    else
      render json: { data: "Not Allowed to use" }, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coupon
      @coupon = Coupon.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def coupon_params
      params.require(:coupon).permit(:coupon_code, :expiry_date, :max_count, :max_amount, :status, :discount_type, :min_amount, :discount)
    end
end
