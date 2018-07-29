Rails.application.routes.draw do
  resources :themes # 이 한줄로 routing(CRUD) 처리 다 한다.
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'board#index'
  get '/boards' => 'board#index'
  get '/board/new' => 'board#new'
  get '/board/:id' => 'board#show'
  post '/boards' => 'board#create'
  get '/board/:id/edit' => 'board#edit'
  put '/board/:id' => 'board#update'
  patch '/board/:id' => 'board#update'
  delete '/board/:id' => 'board#destroy'
  
  #routing users
  get '/users' => 'user#index'
  get '/sign_up' => 'user#new'
  get '/sign_in' => 'user#sign_in'
  post '/sign_in' => 'user#login'
  get '/logout' => 'user#logout'
  get '/user/:id' => 'user#show'
  post '/users' => 'user#create'
  get '/user/:id/edit' => 'user#edit'
  put '/user/:id' => 'user#update'
  
  #routing cafes
  get '/cafes' => 'cafe#index'
  get '/cafe/new' => 'cafe#new'
  get '/cafe/:id' => 'cafe#show'
  post '/cafes' => 'cafe#create'
  get '/cafe/:id/edit' => 'cafe#edit'
  put '/cafe/:id' => 'cafe#update'
  delete '/cafe/:id' => 'cafe#destroy'
  
end
