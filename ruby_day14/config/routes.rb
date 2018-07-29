Rails.application.routes.draw do

  root 'cafes#index' #게시판 글 전부 볼 수 있는 index 페이지
  resources :posts
  
  # comment routes
  post 'posts/:id/comments/create' => 'comments#create'
  delete 'comments/:id' => 'comments#destroy'
  get 'comments/destroy'

  # authenticate routes
  get '/sign_up' => 'authenticate#sign_up'
  post '/sign_up' => 'authenticate#user_sign_up'
  get '/sign_in' => 'authenticate#sign_in'
  post '/sign_in' => 'authenticate#user_sign_in'
  delete '/sign_out' => 'authenticate#sign_out'
  get '/user_info/:user_name' => 'authenticate#user_info'
  
  # cafe routes
  resources :cafes, except: [:destroy]
  post '/join_cafe/:cafe_id' => 'cafes#join_cafe', as: 'join_cafe'
  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
