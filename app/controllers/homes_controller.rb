class HomesController < ApplicationController

	def top
		##ランキング機能
		#postモデルに詳細を記載
		@all_ranks = Post.all_ranks
  	end

  	def about
  	end
end