Rails.application.routes.draw do
  get 'friendships/destroy'

  resources :user_stocks, except: [:show, :edit, :update]
  get 'show_profile' => 'users#show_profile'
  resources :friendships
  devise_for :users
  get 'welcome/index'
  root 'welcome#index'
  get 'my_portfolio' => 'users#my_portfolio'
  get 'search_stocks' => 'stocks#search'
  get 'my_friends' => 'users#my_friends'
  get 'search_friends' => 'users#search'
  post 'add_friend' => 'users#add_friend'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
