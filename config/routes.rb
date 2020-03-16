Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'sign-up', to: 'registrations#new'
  post 'sign-up', to: 'registrations#create'

  get 'welcome/index'
  root 'welcome#index'
end
