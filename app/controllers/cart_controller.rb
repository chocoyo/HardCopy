class CartController < ApplicationController
  def create
    session[:cart] << params[:id].to_i
    flash[:notice] = "Movie Added To Cart"
    redirect_to root_path
  end

  def destroy; end
end
