class ApplicationController < ActionController::Base

	 before_action :configure_permitted_parameters, if: :devise_controller?
   #クロスサイトリクエストフォージュエリ対策
   protect_from_forgery with: :exception

   protected
   #ログイン後の遷移先指定
   def after_sign_in_path_for(resource)
      flash[:success] = 'ようこそ！ゆっくりしていってね★'
  		top_path
   end
   #新規登録後の遷移先指定
   def after_sign_up_path_for(resource)
  		flash[:notice] = '登録ありがとう！'
  		top_path
   end
   #ログアウト後の遷移先指定
   def after_sign_out_path_for(resource)
      flash[:logout] = 'ありがとう！素敵な1日を♫'
  		top_path
   end
   #ストロングパロメーター
	 def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :email])
   devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
	 end
end