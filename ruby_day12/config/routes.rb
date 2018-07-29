Rails.application.routes.draw do

  post 'posts/:id/comments/create' => 'comments#create'
  delete 'comments/:id' => 'comments#destroy'
  get 'comments/destroy'

  root 'posts#index' #게시판 글 전부 볼 수 있는 index 페이지
  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
