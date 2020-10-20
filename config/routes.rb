Rails.application.routes.draw do
  ##devise
	devise_for :users, controllers: {
		sessions: 'users/sessions',
    	registrations: 'users/registrations',
    	passwords: 'users/passwords'
  	}

  get '/' => 'homes#top', as: 'top'
  get '/about' => 'homes#about', as: 'about'
  ##user
  resources :users, only: [:show, :edit, :update] #do
    #resource :relationships, only: [:create, :destroy]
    #フォローをする
  	#get 'follows' => 'relationships#follower'
    #フォローを外す
  	#get 'followers' => 'relationships#followed'
    ##DN機能
    #resources :messages, only: [:create, :destroy]
    #resources :rooms, only: [:show, :create]
    ##問い合わせ機能
    #resources :inquiries, only: [:new]
  #end
  ##post
  resources :posts do
    ##コメント機能
  	resources :comments, only: [:create, :destroy]
    ##いいね機能
  	resource :likes, only: [:create, :destroy]
  	#resource :bookmarks, only: [:create, :destroy]
  end
    ##通知機能
    resources :notifications, only: :index
    #通知をすべて削除する
    delete 'notifications' => 'notifications#destroy_all', as: 'destroy_all_notifications'
    ##タグ検索機能
    #get '/post/tag/:name' => 'posts#tag'
end