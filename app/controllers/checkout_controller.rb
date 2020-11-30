class CheckoutController < ApplicationController
  def checkout
    # Create New Order
    @order = Order.new
    @order.user_id = current_user
    @order.order_status_id = OrdersStatus.find_or_create_by(name: "New")
    @order.PST = current_user.province.PST
    @order.GST = Gst.all.last.rate
    @order.total = 10

    # Create Items For That Order
  end
end
