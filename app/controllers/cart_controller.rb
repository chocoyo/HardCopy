class CartController < ApplicationController
  def create
    session[:cart] << params[:id].to_i
    flash[:notice] = "Movie Added To Cart"
    redirect_to root_path
  end


  def destroy
    session[:cart].delete(params[:id].to_i)
    redirect_to root_path
  end

  def show; end
end
