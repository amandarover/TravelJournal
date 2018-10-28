Rails.application.routes.draw do
  get 'dashboard/index'

  root 'dashboard#index'

  resources :travels do
    resources :days
  end

  post '/travels/:id/add_one_day', to: 'travels#add_one_day', as: 'add_travel_day'
end
