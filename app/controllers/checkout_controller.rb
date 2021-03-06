class CheckoutController < ApplicationController
  def checkout; end

  def create
    items_for_line = []

    #
    # Hard Copy Stuff
    #

    # Create New Order
    @order = Order.create
    @order.user_id = current_user.id
    @order.order_status_id = OrdersStatus.where(name: "New").last.id
    @order.total = 0

    # Create Items For That Order
    # Add items to the items
    cart.each do |item|
      items_for_line << {
        name:        item.title,
        description: item.description,
        amount:      item.price,
        currency:    "cad",
        quantity:    1
      }

      @order.total += item.price

      OrderedProduct.create(
        order:         @order,
        movie_id:      item.id,
        quantity:      1,
        price_of_item: item.price
      )
    end

    # Check tax rates for user province
    if current_user.province.HST.nil? || current_user.province.HST.zero?
      @order.PST = current_user.province.PST
      @order.GST = Gst.all.last.rate

      # Throw the taxes in
      items_for_line << {
        name:        "GST",
        description: "Goods And Services Tax",
        amount:      (@order.total * @order.GST) / 100,
        currency:    "cad",
        quantity:    1
      }

      # Throw the taxes in
      items_for_line << {
        name:        "PST",
        description: "Provincial Sales Tax",
        amount:      (@order.total * @order.PST) / 100,
        currency:    "cad",
        quantity:    1
      }

    else
      @order.HST = current_user.province.HST

      # Throw the taxes in
      items_for_line << {
        name:        "HST",
        description: "Harmonized Sales Tax",
        amount:      (@order.total * @order.HST) / 100,
        currency:    "cad",
        quantity:    1
      }
    end

    # Connect with stripe
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      success_url:          "#{checkout_success_url}?session_id={CHECKOUT_SESSION_ID}",
      cancel_url:           checkout_cancel_url,
      line_items:           items_for_line
    )

    @order.StripeID = @session.id
    @order.save

    respond_to do |format|
      format.js
    end
  end

  def success
    # Success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)

    # Mark order as paid
    @order = Order.where(StripeID: params[:session_id]).last
    @order.order_status_id = OrdersStatus.where(name: "Paid").last.id
    @order.save

    # Reset shopping cart
    session[:cart] = []
  end

  def cancel
    # Something went wrong
  end
end
