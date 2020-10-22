class CommentsController < ApplicationController
	#アクセス制限
	before_action :authenticate_user!

	def create
		@post = Post.find(params[:post_id])
		@comment = current_user.comments.new(comment_params)
		@comment.post_id = @post.id
		if @comment.save
		   @post.create_notification_comment(current_user, @comment.id) #コメント通知
		   flash[:success] = 'コメントありがとう！'
		   redirect_to post_path(@post)
		else
		   flash[:failure] = 'コメントできませんでした'
		   redirect_to post_path(@post)
		end
	end

	def destroy
		@post = Post.find(params[:post_id])
		@comment = current_user.comments.find_by(id: params[:id], post_id: @post.id)
		@comment.destroy
        flash[:success] = 'コメントを削除しました'
        redirect_to request.referer
	end
	#ストロングパロメーター
	private
	def comment_params
		params.require(:comment).permit(:content)
	end
end