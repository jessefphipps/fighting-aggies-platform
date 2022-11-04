Rails.application.routes.draw do
  root 'login#loginPage'
  namespace :api do
    namespace :v1 do
      get 'videos/index'
      post 'videos/create'
      get 'videos/show'
      delete 'videos/destroy'
      get 'model_api/index'
      post 'model_api/create'
      get 'model_api/show'
      delete 'model_api/destroy'
    end
  end
  
  get 'dashboard', to: 'pages#home'
end