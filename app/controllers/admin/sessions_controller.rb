include SessionsHelper
class Admin::SessionsController < ApplicationController
  def new
  end

  def create
    user = User.where("email = ? AND encrypted_password = ? ", params[:email].downcase,params[:encrypted_password]).first
    if user
      sign_in user
      #flash.now[:error] = 'Login successfull !'
      redirect_back_or admin_user
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
  end
end
