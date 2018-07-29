Rails.application.routes.draw do
  resources :socars

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get '/tests' => 'tests#index'
  get '/test/new' => 'tests#new'
  post '/tests' => 'tests#create'
  get '/test/:id' => 'tests#show'
  get '/test/:id/edit' => 'tests#edit'
  put '/test/:id' => 'tests#update'
  patch '/test/:id'=> 'tests#update'
  delete '/test/:id' => 'tests#destroy'
  
end
