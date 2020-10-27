class RoomsController < ApplicationController
    ##アクセス制限
	#before_action :authenticate_user!

	def show
		@room = Room.find(params[:id])
		#entriesテーブルに自身と紐付くメッセージルームがあるかを確認
		if Entry.where(user_id: current_user.id, room_id: @room.id).present?
			@messages = @room.messages
			@message = Message.new
			#メッセージルームのユーザー情報を表示させる
			@entries = @room.entries
		else
			#直前のページにリダイレクトする
			redirect_back(fallback_location: room_path)
		end
	end

	def create
		@room = Room.create
		#自身のEntry
		@entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
		#DMを受け取るユーザーのEntry
		@entry2 = Entry.create((entry_params).merge(room_id: @room.id))
		redirect_to "/rooms/#{@room.id}"
	end
	##ストロングパロメーター
	private
	def entry_params
		#require(:entry)があるとエラーになってしまう➡︎あってもエラーが出なくなった、DM機能動くようになった。なぜ？
		params.require(:entry).permit(:user_id, :room_id)
	end
end