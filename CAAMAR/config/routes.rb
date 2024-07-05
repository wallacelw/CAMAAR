Rails.application.routes.draw do
  resources :usuarios

  root 'auth#login'

  get '/definir-senha/:id', to: 'auth#define_password'

  get 'gerenciamento', to: 'gerenciamento#index'
  get 'gerenciamento/templates', to: 'gerenciamento#show_templates'
  get 'gerenciamento/results_popup'
  get 'gerenciamento/generate_csv'

  get 'turmas', to: 'turmas#index'

  get 'avaliacoes', to: 'avaliacoes#index'

  # resource to read json files
  get 'uploader', to: 'uploader#index'
  get "statistics", to: "forms_statiscis#index"
  resources :jsonfiles do
    collection do
      post :import
    end
  end
  resources :forms_statiscis do
    get :form, on: :collection
  end
  # resource to create forms
  resource :formcreates do
    collection do
        post :import
    end
  end


  #
  get 'forms_answer/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'forms_answer/new/:form_id/:solver_id', to: 'forms_answer#new'
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  post '/import_formanswercreates', to: 'forms_answer#create', as: 'import_formanswercreates'


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "statistics", to: "forms_statiscis#index"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
