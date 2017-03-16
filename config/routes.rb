Rails.application.routes.draw do
  get 'documents/index'
  get 'documents/vista_pdf_header'
  get 'documents/vista_pdf_footer'
  get 'documents/vista_pdf_ca'
  get 'documents/progrehab_pdf_ca'

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
  resources :edificis
  resources :identificacions
  
  devise_for :users
  get 'home/index'
  get 'home/contacta'
  get 'home/permisos'

  
  root :to => "home#index"
end
