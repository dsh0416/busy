require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  get '', to: 'home#index'

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'badges/:user_id', to: 'badges#show'
  resources :calendars do
    get 'retrieve', to: 'calendars#retrieve'
  end

  mount Sidekiq::Web => '/sidekiq'
end
