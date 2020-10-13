Rails.application.routes.draw do

	devise_for :users, controllers: {
		sessions: 'users/sessions',
    	registrations: 'users/registrations',
    	passwords: 'users/passwords'
  	}

  	get '/' => 'homes#top', as: 'top'
  	get '/about' => 'homes#about', as: 'about'
  	resources :users, only: [:show, :edit, :update]
  	resources :inquiries, only: [:new]
  	resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy]
end