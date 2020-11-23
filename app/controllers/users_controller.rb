class UsersController < ApplicationController
  def show
    if user_signed_in?
      @user = current_user
    else
      # Redirect Somewhere
      redirect_to("/")
    end
  end
end
