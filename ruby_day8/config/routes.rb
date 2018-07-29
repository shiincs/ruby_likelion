Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'tweet#index'
  get '/tweets' => 'tweet#index'
  get '/tweet/new' => 'tweet#new'
  post '/tweet/create' => 'tweet#create'
  get '/tweet/:id' => 'tweet#show'
  get '/tweet/:id/edit' => 'tweet#edit'
  post '/tweet/:id/update' => 'tweet#update'
  get '/tweet/:id/delete' => 'tweet#delete'
end
