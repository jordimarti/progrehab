Rails.application.routes.draw do
  resources :empresa_factures
  resources :usuari_factures
  resources :empresa_facturas
  resources :usuari_facturas
  get 'documents/index'
  get 'edificis/pdf_header'

  resources :tresoreries
  resources :ingressos
  resources :despeses
  get 'planificacions/fases', to: 'planificacions#fases', :as => :fases_planificacio
  get 'planificacions/calendari', to: 'planificacions#calendari', :as => :calendari
  get 'planificacions/crea_valors_inicials', to: 'planificacions#crea_valors_inicials', :as => :crea_valors_inicials
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

  get 'pagaments/crear_pagament', to: 'pagaments#crear_pagament', :as => :crear_pagament
  get 'pagaments/validar_dades', to: 'pagaments#validar_dades', :as => :validar_dades 

  resources :edificis do
    resource :download, only: [:show]
  end
  resources :identificacions
  
  devise_for :users
  get 'home/index'
  get 'home/contacta'
  get 'home/permisos'
  get 'home/tutorial'

  
  root :to => "home#index"
end
