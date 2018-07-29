class BoardController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  # before_action :set_post, except: [:index, :new, :create]
  # 로그인 된 상태에서만 접속할 수 있는 페이지는?
  # index, show만 로그인 하지 않은 상태에서 볼 수 있게
  # 나머지는 반드시 로그인이 필요하게
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    @posts = Post.all
    current_user
    @title = "여기는 인덱스야"
  end

  def show
    # @post = Post.find(params[:id])
    #set_post  # set_post 메소드에서 설정했기 때문에 여기서 사용 가능(한 요청 안에서)
  end

  def new
  end
  
  def create
    # post = Post.new(title: params[:title], contents: params[:contents], user_id: current_user.id)
    # post.save
    # .create 메서드는 .new와 .save를 한번에 진행한다.
    post = Post.create(post_params)
    # post.title = params[:title]
    # post.contents = params[:contents]
    # post.user_id = current_user.id
    
    # post를 등록할 때 이 글을 작성한 사람은
    # 현재 로그인 되어 있는 유저이다.
    
    redirect_to "/board/#{post.id}"
  end
  
  def edit
    # @post = Post.find(params[:id])
    # set_post
  end
  
  def update
    # @post = Post.find(params[:id])
    # set_post
    # .update 메서드는 원래 있던 내용물을 바로 update 시킴(save 필요x)
    @post.update(post_params)
    # @post.title = params[:title]
    # @post.contents = params[:contents]
    # @post.save
    redirect_to "/board/#{@post.id}"
  end
  
  def destroy
    # @post = Post.find(params[:id])
    # set_post
    @post.destroy
    redirect_to "/boards"
  end
  
  def set_post
    @post = Post.find(params[:id])
  end
  
  def post_params
    {title: params[:title], contents: params[:contents], user_id: current_user.id}
  end
end
