Rails.application.routes.draw do
  get 'dashboard/index'

  root 'dashboard#index'

  resources :travels do
    resources :days
  end
end
