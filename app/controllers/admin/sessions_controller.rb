include SessionsHelper
class Admin::SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      flash.now[:error] = 'Login successfull !'
      redirect_back_or admin_users_path
    else
      flash[:error] = 'Invalid email/password combination' # Not quite right!
      redirect_to admin_signin_path
    end
  end
  def destroy
    sign_out
    redirect_to root_url
  end
end
