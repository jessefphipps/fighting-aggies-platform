Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'videos/index'
      post 'videos/create'
      get 'videos/show'
      delete 'videos/destroy'
    end
  end
  get 'videos/index'
  post 'videos/create'
  get '/show/:id', to: 'videos#show'
  delete '/destroy/:id', to: 'videos#destroy'
  
  root 'pages#home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
#   # root "articles#index"
#   root 'welcome#index'
  
  get 'login', to: 'login#loginPage'
  
end