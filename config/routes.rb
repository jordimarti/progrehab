Rails.application.routes.draw do
  resources :fases
  resources :intervencions
  resources :deficiencies
  resources :qualificacions
  resources :edificis
  resources :identificacions
  
  devise_for :users
  get 'home/index'
  get 'home/contacta'
  get 'home/permisos'
  
  root :to => "home#index"
end
