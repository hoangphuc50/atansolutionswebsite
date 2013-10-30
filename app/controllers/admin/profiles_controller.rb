class Admin::ProfilesController < ApplicationController
  #before_action :signed_in_user
  layout 'admin'

  def index
  end

  def update_password
    if user = User.where('email = ? AND encrypted_password = ? ',current_user.email, params[:encrypted_password]).first
      if params[:new_password].eql?(params[:password_confirmation])
        user.encrypted_password = params[:password_confirmation]
        if user.update_attribute(:encrypted_password,params[:password_confirmation])
          flash.now[:error] = "Password Updated"
          render 'index'
        else
          flash.now[:error] = "Password Update False"
          render 'index'
        end
      else
        flash.now[:error] = "2 new password incorrect !"
        render 'index'
      end

    else
      flash.now[:error] = "Invalid current password"
      render 'index'
    end
  end
end
