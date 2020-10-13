class UsersController < ApplicationController
  #アクセス制限
  before_action :authenticate_user!

  def show
      @user = User.find(params[:id])
  end

  def edit
      @user = User.find(params[:id])
  end

  def update
      @user = User.find(params[:id])
      if @user.update(user_params)
         flash[:notice] = '更新しました'
         redirext_to user_path
      else
         render :show
      end
  end

  private
  def user_params
  	  params.require(:user).permit(:nickname, :email, :profile_image)
  end
end