Rails.application.routes.draw do
  root 'login#loginPage'
  namespace :api do
    namespace :v1 do
      get 'videos/index'
      post 'videos/create'
      get 'videos/show'
      delete 'videos/destroy'
      
      get 'visions/index'
      post 'visions/create'
      get 'visions/show'
      delete 'visions/destroy'
      
      get 'analyses/index'
      post 'analyses/create'
      get 'analyses/show'
      delete 'analyses/destroy'
    end
  end
  
  get 'dashboard', to: 'pages#home'
end