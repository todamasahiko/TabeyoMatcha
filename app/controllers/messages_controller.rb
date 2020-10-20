class MessagesController < ApplicationController
    ##アクセス制限
    #before_action :authenticate_user!

	#ef create
		#formで作られたroom_idと自身のユーザーIDがEntryにあるかを確認
		#if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
			#@message = Message.create((message_params).merge(user_id: current_user.id))
			#flash[:success] = 'メッセージの送信に成功しました'
			#redirect_back(fallback_location: root_path)
		#else
			#flash[:alert] = 'メッセージの送信に失敗しました'
			#redirect_back(fallback_location: root_path)
		#end
	#end

	#def destroy
		#@message = Message.find(params[:id])
		#if @message.destroy
		   #flash[:success] = 'メッセージの削除に成功しました'
		   #redirect_back(fallback_location: root_path)
		#else
		   #flash[:alert] = 'メッセージの削除に失敗しました'
		   #redirect_back(fallback_location: root_path)
		#end
	#end
	##ストロングパロメーター
	def message_params
		params.require(:message).permit(:user_id, :room_id, :content)
	end
end