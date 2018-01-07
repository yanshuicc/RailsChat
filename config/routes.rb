Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

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
      get :index
      get :chats_show
      get :messages_show
    end
  end

  resources :messages do
    collection do
      get :destroyall
    end
  end

  resources :chats do
    member do
      patch :trans_auth
      post :add_user
      delete :delete_user
    end
  end

  resources :friendships do
    collection do
      post :agree
      get :index_json
    end
  end

  resources :messagesreadflag

  root 'homes#home'

  get 'managers/index'
  post 'sessions/register' => 'sessions#register'
  post 'sessions/login' => 'sessions#login'
  delete 'sessions/logout' => 'sessions#destroy'
end