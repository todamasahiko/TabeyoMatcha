Rails.application.routes.draw do

  devise_for :users
  get '/' => 'homes#top', as: 'top'
  get '/about' => 'homes#about', as: 'about'

end
