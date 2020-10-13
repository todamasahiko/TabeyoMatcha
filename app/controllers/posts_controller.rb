class PostsController < ApplicationController
    #アクション制限
    before_action :authenticate_user!, except: [:index, :show]

	def index
		@posts = Post.all
	end

	def show
		@post = Post.find(params[:id])
	end

	def new
		@post = Post.new
	end

	def create
    	@post = Post.new(post_params)
    	@post.user_id = current_user.id
    	if @post.save
    	   flash[:notice] = '投稿に成功しました'
    	   redirect_to posts_path
    	else
    	   flash[:alert] = '投稿に失敗しました'
    	   render :new
    	end
	end

	def edit
		@post = Post.find(params[:id])
		if @post.user != current_user
		   redirect_to posts_path
		end
	end

	def update
		@post = Post.find(params[:id])
		@post.user_id = current_user.id
		if @post.update(post_params)
		   flash[:notice] = '更新に成功しました'
		   redirect_to posts_path
		else
			flash[:alert] = '更新に失敗しました'
			render :edit
		end
	end

	def destroy
		@post = Post.find(params[:id])
		if @post.destroy
		   flash[:notice] = '削除に成功しました'
		   redirect_to posts_path
		else
			render :index
		end
	end
    #ストロングパロメーター
	private
	def post_params
		params.require(:post).permit(:user_id, :content, :tag_content, :image)
	end
end