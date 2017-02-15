Rails.application.routes.draw do
  resources :edificis
  resources :identificacions
  
  devise_for :users
  get 'home/index'
  get 'home/contacta'
  get 'home/permisos'
  
  root :to => "home#index"
end
