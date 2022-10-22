Rails.application.routes.draw do
  root 'login#loginPage'
  namespace :api do
    namespace :v1 do
      get 'videos/index'
      post 'videos/create'
      get 'videos/show'
      delete 'videos/destroy'
    end
  end
  
  get 'dashboard', to: 'pages#home'
end