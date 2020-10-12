class UsersController < ApplicationController

	before_action :authenticate_user!, except: [:top, :about]

	def show
  	end

  	def edit
  	end

  	def update
  	end

  	private
  	def user_params
  	  params.require(:user).permit(:nickname, :email, :profile_image)
  	end
end