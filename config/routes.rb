Rails.application.routes.draw do
  root 'static_pages#top'
  get '/signup', to: 'users#new'

  # ログイン機能
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  get '/auth/line', to: 'sessions#line', as: 'line_login'
  get '/auth/:provider/callback', to: 'sessions#create'
  
  delete '/logout', to: 'sessions#destroy'

  resources :users do
    member do
      get 'edit_basic_info'
      patch 'update_basic_info'
    end

    resources :items do
      put 'mark_as_arranged', on: :member
      put 'request_arrange', on: :member
      put '/users/:user_id/items/:id/register_destination', to: 'items#register_destination', as: 'register_destination_user_item'
      put 'copy', to: 'items#copy', on: :member
    end
    
  end
end