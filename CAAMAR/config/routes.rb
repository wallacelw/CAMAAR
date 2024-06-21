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

  get 'template', to: 'template#index'
  get 'getemps', to: 'gerenciamento#show_templates'

  post 'delete_template', to: 'template#delete_template', as: 'delete_template'

  resources :jsonfiles do
    collection do
      post :import
    end
  end

  # resource to create forms
  resource :formcreates do
    collection do
        post :import
    end
  end

  # resource to suposebly create template
  resource :templatecreates do
    collection do
      post :import
    end
  end

  resource :template do
    collection do
      post :delete
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
