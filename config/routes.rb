Rails.application.routes.draw do
  get 'dashboard/index'

  root 'dashboard#index'

  resources :travels do
    resources :days
  end

  post '/travels/:id/add_one_day', to: 'days#add_one_day', as: 'add_travel_day'
  delete '/travels/:id/delete_one_day/:where_to_destroy', to: 'days#destroy_one_day', as: 'destroy_travel_day'
end
