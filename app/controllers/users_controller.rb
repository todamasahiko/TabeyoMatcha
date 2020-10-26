class UsersController < ApplicationController
  ##アクセス制限
  before_action :authenticate_user!

  def show
      @user = User.find(params[:id])
      @post = Post.find(params[:id])
      @posts = @user.posts
      #ログインユーザーの「いいね」したpost_idを取得
      like = Like.where(user_id: current_user.id).pluck(:post_id)
      #Postテーブルから「いいね」済レコードを取得
      @like_posts = @user.like_posts
      #ログインユーザーの「コメント」したpost_idを取得
      #comments = Comment.where(user_id: current_user.id).pluck(:post_id)
      #Postテーブルから「コメント」済レコードを取得
      #@comment_posts = Comment.find(comments)
      ##DM機能
      #自身の参加しているメッセージルームの情報を取得する
      @current_entry = Entry.where(user_id: current_user.id)
      #選択したユーザーのメッセージルーム情報を取得する
      @another_entry = Entry.where(user_id: @user.id)
      #自身と選択したユーザーの共通メッセージルームがあるかを確認
      if @user.id != current_user.id
        #自身と選択したユーザーのEntriesをそれぞれ取り出す
        @current_entry.each do |current|
          @another_entry.each do |another|
            #すでに作成済の場合
            if current.room_id == another.room_id
              @isRoom = true
              #room_idを取り出す
              @roomId = current.room_id
            end
          end
        end
        #まだ未作成の場合
        unless @isRoom
          @room = Room.new
          @entry = Entry.new
        end
      end
  end

  def edit
      @user = User.find(params[:id])
  end

  #def create
    #@room = Room.create
    #自身のEntry
    #@entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
    #DMを受け取るユーザーのEntry
    #@entry2 = Entry.create((entry_params).merge(room_id: @room.id))
    #redirect_to room_path(@room)
  #end

  def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        flash[:notice] = '更新しました'
        redirect_to user_path(@user.id)
      else
        render :edit
      end
  end
  #フォローをする
  #def follows
     #@user = User.find(params[:id])
     #@users = @user.follows
  #end
  #フォローを外す
  #def followers
      #@user = User.find(params[:id])
      #@users = @user.followers
  #end
  ##ストロングパロメーター
  private
  def user_params
  	  params.require(:user).permit(:nickname, :email, :profile_image, :password)
  end
end