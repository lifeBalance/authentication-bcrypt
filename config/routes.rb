Rails.application.routes.draw do

  # Named routes for our sessions, in charge of the
  # login and logout features
  get    'login',  :to => 'sessions#new'
  post   'login',  :to => 'sessions#create'
  delete 'logout', :to => 'sessions#destroy'

  # Named route for signing up users
  resources :users, path_names: { new: 'signup' }, except: [:edit, :update]

  # More routes for our static pages
  get 'static_pages/home'
  get 'welcome',         :to => 'static_pages#welcome'
  get 'not_in_the_list', :to => 'static_pages#not_in_the_list'

  # Setting the root to home
  root 'static_pages#home'
end
