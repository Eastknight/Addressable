class UsersController < ApplicationController

  def check_email
    email = params[:user][:email]

    record = User.find_by_email(email)
    if record
      render :json => false
    else
      render :json => true
    end    
  end
end
