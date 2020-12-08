class CheckoutController < ApplicationController
  def checkout
    # Create New Order
    @order = Order.new
    @order.user_id = current_user
    @order.order_status_id = OrdersStatus.find_or_create_by(name: "New")

    # Check tax rates for user province
    if current_user.province.HST.nil? || current_user.province.HST.zero?
      @order.PST = current_user.province.PST
      @order.GST = Gst.all.last.rate
    else
      @order.HST = current_user.province.HST
    end

    @order.total = 10

    # Create Items For That Order
  end
end
