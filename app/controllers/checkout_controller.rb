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

  def create
    items_for_line = []

    # Add items to the items
    cart.each do |item|
      items_for_line << {
        name:        item.title,
        description: item.description,
        amount:      item.price,
        currency:    "cad",
        quantity:    1
      }
    end

    # Throw the taxes in
    items_for_line << {
      name:        "GST",
      description: "Goods And Services Tax",
      amount:      13,
      currency:    "cad",
      quantity:    1
    }

    # Connect with stripe
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      success_url:          checkout_success_url,
      cancel_url:           checkout_cancel_url,
      line_items:           items_for_line
    )

    respond_to do |format|
      format.js
    end
  end

  def success
    # Success
  end

  def cancel
    # Something went wrong
  end
end
