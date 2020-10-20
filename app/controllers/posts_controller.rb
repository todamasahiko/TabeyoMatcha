class PostsController < ApplicationController
    ##アクション制限
    before_action :authenticate_user!, except: [:index]
    ##PV機能(IPアドレスで計測)
    impressionist :action => [:show], :unique => [:impressionable_id, :ip_address]

	def index
		@posts = Post.all
		#@tag_list = Tag.all
	end

	def show
		@post = Post.find(params[:id])
		##PV機能
		impressionist(@post, nil, unique: [:impressionable_id, :ip_address])
        #投稿に紐付くタグの取得
		#@post_tags = @post.tags
		@comment = Comment.new
		@comments = @post.comments
	end

	def new
		@post = Post.new
	end

	def create
    	@post = Post.new(post_params)
    	@post.user_id = current_user.id
    	#tag_list = params[:post][:name].split(nil)
    	if @post.save
    	   #@post.save_tag(tag_list)
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
			flash[:alert] = '削除に失敗しました'
			render :index
		end
	end
	##タグ検索機能
	#def tag
		#@user = current_user
		#@tag = Tag.find_by(name: params[:name])
		#tag_content = Tag.find(params[:id])
	#end
    ##ストロングパロメーター
	private
	def post_params
		params.require(:post).permit(:user_id, :content, :tag_content, :image)
	end

	#def save_tags(sent_tags)
		#すでに投稿に登録されているタグを取得
		#current_tags = self.tags.pluck(:name) unless self.tags.nil?
		#古いタグを取得する
		#old_tags = current_tags - sent_tags
		#新しいタグを取得する
		#new_tags = sent_tags - current_tags
		#old_tags.each do |old_name|
			#古いタグを削除する
			#self.tags.delete Tag.find_by(name: old_name)
		#end

		#new_tags.each do |new_name|
			#新しいタグを登録する
			#new_post_tag = Tag.find_or_creare_by(name: new_name)
			#新しいタグをpostに追加する
			#self.tags << new_post_tag
		#end
	#end
end