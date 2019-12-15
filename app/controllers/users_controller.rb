class UsersController < ApplicationController
  load_and_authorize_resource
  def show

  end
  def edit

  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".success"
      redirect_to user_path
    else
      flash.now[:error] = t ".error"
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:fullname, :address, :phone, :email, :password, :password_confirmation)
  end
end
