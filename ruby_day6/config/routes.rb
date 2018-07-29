Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index' # get '/' => 'home#index'와 같다.
  # home#index -> home controller의 index action으로 가라
  # get '/lotto' => 'home#lotto'
  get '/lunch' => 'home#lunch'
  
  get '/users' => 'user#index'
  get '/user/:id' => 'user#show'    # wildcard
  get '/users/new' => 'user#new'
  post '/user/create' => 'user#create'
  
  get '/lotto' => 'lotto#index'
  get '/lotto/new' => 'lotto#new'
end
