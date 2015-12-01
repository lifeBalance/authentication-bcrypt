Rails.application.routes.draw do

  # Named routes for our sessions, in charge of the
  # login and logout features.
  # get 'sessions/new', :to => 'sessions#new', :as => 'login'
  # Same as:
  get    'login'  => 'sessions#new'
  post   'login'  => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  # Named routes for users
  get 'signup'    =>  'users#new'
  # RESTful routes for users
  resources :users, only: [:new, :create, :show, :destroy]

  # More routes for our static pages
  get 'welcome'         => 'static_pages#welcome'
  get 'not_in_the_list' => 'static_pages#not_in_the_list'

  # Setting the root to home
  root 'static_pages#home'
end
