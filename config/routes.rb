Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
    get '/show', to: 'user#show', as: 'show'
    get '/index', to: 'user#index', as: 'index'
    post '/create', to: 'user#create', as: 'create'
    patch '/update', to: 'user#update', as: 'update'
    delete '/delete', to: 'user#destroy', as: 'delete'

    post '/authenticate', to: 'authentication#authenticate', as: 'authenticate'
    get '/authenticate_token', to: 'authentication#authenticate_token', as: 'authenticate_token'

    end
  end


end
