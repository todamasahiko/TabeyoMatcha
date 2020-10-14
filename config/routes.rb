Rails.application.routes.draw do

	devise_for :users, controllers: {
		sessions: 'users/sessions',
    	registrations: 'users/registrations',
    	passwords: 'users/passwords'
  	}

  	get '/' => 'homes#top', as: 'top'
  	get '/about' => 'homes#about', as: 'about'
  	resources :users, only: [:show, :edit, :update] do
  		resource :relationships, only: [:create, :destroy]
  		get 'follows' => 'relationships#follower'
  		get 'followers' => 'relationships#followed'
  	end
  	resources :inquiries, only: [:new]
  	resources :posts do
  		resources :comments, only: [:create, :destroy]
  		resource :likes, only: [:create, :destroy]
  		resource :bookmarks, only: [:create, :destroy]
  	end
end