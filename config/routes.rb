Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :friendships
  resources :users do
    collection do
      get :index_json
    end
  end
  resources :salaries
  resources :performances
  resources :announcements
  resources :materials
  resources :articles
  resources :departments
  resources :companynews
  resources :vacation
  resources :messages do
    collection do
      delete :destroyall
    end
  end
  resources :chats do
    member do
      patch :trans_auth
      post :add_user
      delete :delete_user
    end
  end
  resources :friendships

  root 'homes#home'

  post 'sessions/register' => 'sessions#register'
  post 'sessions/login' => 'sessions#create'
  delete 'sessions/logout' => 'sessions#destroy'
end
