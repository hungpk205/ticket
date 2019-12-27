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

  def destroy
    @user = User.find_by_id params[:id]
    if @user.destroy
      flash[:success] = t ".success"
    else
      flash[:error] = t ".error"
    end
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:fullname, :address, :phone, :email, :password, :password_confirmation)
  end
end
