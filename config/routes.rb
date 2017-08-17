Rails.application.routes.draw do
  resources :user_stocks, except: [:show, :edit, :update]
  resources :users, only: [:show]
  resources :friendships
  devise_for :users
  get 'welcome/index'
  root 'welcome#index'
  get 'my_portfolio' => 'users#my_portfolio'
  get 'search_stocks' => 'stocks#search'
  get 'my_friends' => 'users#my_friends'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
