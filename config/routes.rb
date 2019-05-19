Rails.application.routes.draw do
  get 'sessions/create'

  get 'sessions/destroy'

  get 'home/show'

  get 'travels/index'

  # root 'travels#index'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show]

  root to: 'home#show'

  resources :travels do
    resources :days do
      resources :events
    end
  end

  post '/travels/:id/add_one_day', to: 'days#add_one_day', as: 'add_travel_day'
  delete '/travels/:id/delete_one_day/:where_to_destroy', to: 'days#destroy_one_day', as: 'destroy_travel_day'
end
