Rails.application.routes.draw do
  get 'managers/index'

  get 'manager/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :friendships
  resources :users do
    collection do
      get :index_json
    end
  end
  resources :managers do
    member do
      delete :destroy
      post :index_edit
      get :index_edit
      patch :index_update
    end
    collection do
      get :chats_show
      get :messages_show
    end
  end
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
  resources :messagesreadflag

  root 'homes#home'

  post 'sessions/register' => 'sessions#register'
  post 'sessions/login' => 'sessions#login'
  delete 'sessions/logout' => 'sessions#destroy'
end