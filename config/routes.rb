Rails.application.routes.draw do
  get 'sessions/create'

  get 'sessions/destroy'

  get 'home/show'

  get 'travels/index'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'login', to: 'sessions#login', as: 'login'

  resources :sessions,
            only: [
              :create,
              :destroy
            ]
  resource :home, only: [:show]

  root to: 'home#show'

  resources :travels do
    resources :days, only: [:show] do
      resources :events,
                only: [
                  :create,
                  :new,
                  :edit,
                  :update,
                  :destroy
                ]
    end
  end

  get '/travels/:id/add_one_day/:where_to_add', to: 'days#add_one_day', as: 'add_travel_day'
  delete '/travels/:id/delete_one_day/:where_to_destroy', to: 'days#destroy_one_day', as: 'destroy_travel_day'
end
