class CheckoutBasketsController < ApplicationController
  def index
  end

  def calculations
    basket = BasketService.new(params[:items])
    basket.calculate_basket
    respond_to do |format|
      format.html { render json: basket.sub_total }
    end
  end

  def orders
    @items = params[:checkouts][:orders].split(',')
    @basket = BasketService.new(@items)
    @basket.calculate_basket
  end
end
