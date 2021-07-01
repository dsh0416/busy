Rails.application.routes.draw do
  get '', to: 'home#index'
  put 'users/:id/shorthand', to: 'users#update_shorthand'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'badges/:shorthand', to: 'badges#show'
  resources :calendars do
    post 'retrieve', to: 'calendars#retrieve'
    get 'history', to: 'calendars#history'
  end
end
