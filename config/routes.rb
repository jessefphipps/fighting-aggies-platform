Rails.application.routes.draw do
  root 'login#loginPage'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
#   # root "articles#index"
#   root 'welcome#index'
  
  get 'login', to: 'login#loginPage'
  get 'dashboard', to: 'pages#home'
end