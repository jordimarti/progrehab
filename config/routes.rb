Rails.application.routes.draw do
  resources :ingressos
  resources :derrames
  get 'planificacions/fases', to: 'planificacions#fases', :as => :fases_planificacio
  get 'planificacions/calendari', to: 'planificacions#calendari', :as => :calendari
  resources :planificacions
  resources :fases
  #get 'intervencions/assignacions', to: 'intervencions#assignacions', :as => :assignacions
  resources :intervencions do
    collection do
      get :assignacions
      put :assigna
    end
  end
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
