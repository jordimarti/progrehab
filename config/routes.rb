Rails.application.routes.draw do
  devise_for :users
  get 'home/index'
  get 'home/contacta'
  
  root :to => "home#index"
end
