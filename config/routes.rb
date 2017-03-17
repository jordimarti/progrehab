Rails.application.routes.draw do
  get 'documents/index'
  get 'edificis/pdf_header'

  resources :tresoreries
  resources :ingressos
  resources :derrames
  get 'planificacions/fases', to: 'planificacions#fases', :as => :fases_planificacio
  get 'planificacions/calendari', to: 'planificacions#calendari', :as => :calendari
  resources :planificacions
  resources :fases
  #get 'intervencions/assignacions', to: 'intervencions#assignacions', :as => :assignacions
  get 'intervencions/exporta_xml', to: 'intervencions#exporta_xml', :as => :exporta_xml
  resources :intervencions do
    collection do
      get :assignacions
      put :assigna
    end
  end

  resources :deficiencies
  resources :qualificacions
  resources :edificis do
    resource :download, only: [:show]
  end
  resources :identificacions
  
  devise_for :users
  get 'home/index'
  get 'home/contacta'
  get 'home/permisos'

  
  root :to => "home#index"
end
