class BookmarksController < ApplicationController
	#アクセス制限
	before_action :authenticate_user!

	def create
	end

	def destroy
	end
end