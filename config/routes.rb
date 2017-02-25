Rails.application.routes.draw do
  get 'intervencions/assignacions', to: 'intervencions#assignacions', :as => :assignacions
  resources :fases
  resources :intervencions do
    collection do
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
