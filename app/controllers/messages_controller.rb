class MessagesController < ApplicationController
    ##アクセス制限
    before_action :authenticate_user!

	def create
		#formで作られたroom_idと自身のユーザーIDがEntryにあるかを確認
		if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
			@message = Message.create((message_params).merge(user_id: current_user.id))
			#@room = @message.room
			flash[:success] = 'メッセージの送信に成功しました。'
			redirect_to "/rooms/#{@message.room_id}"
		else
			flash[:alert] = 'メッセージの送信に失敗しました。'
			redirect_to "/rooms/#{@message.room_id}"
		end
	end

	#def destroy
		#@message = Message.find(params[:id])
		#if @message.destroy
		   #flash[:success] = 'メッセージの削除に成功しました'
		   #直前のページにリダイレクトする
		   #redirect_to "/rooms/#{@message.room_id}"
		#else
		   #flash[:alert] = 'メッセージの削除に失敗しました'
		   #直前のページにリダイレクトする
		   #redirect_to "/rooms/#{@message.room_id}"
		#nd
	#end
	##ストロングパロメーター
	def message_params
		params.require(:message).permit(:user_id, :room_id, :content)
	end
end