class MoviesController < ApplicationController
  before_action :js_authenticate_user!, only: [:like_movie]
  # authenticate_user! 액션은 devise에 구현되어 있고, 가져다 쓰기만 한다.
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  
  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    # 이 부분이 생략되어 있음
    # @movie = Movie.find(params[:id])
    
    @like = Like.where(user_id: current_user.id, movie_id: params[:id]).first
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
    # 이 부분이 생략되어 있음
    # @movie = Movie.find(params[:id])
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(movie_params)
    @movie.user_id = current_user.id
    
    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def like_movie
    p params
    # 현재 유저와 params에 담긴 movie 간의 좋아요 관계를 설정한다.
    # 만약에 현재 로그인한 유저가 이미 좋아요를 눌렀을 경우
    # 해당 Like 인스턴스 삭제
    # 새로 누른 경우 좋아요 관계 설정
    # .where은 배열로 여러개 return 하기 때문에 .first
    @like = Like.where(user_id: current_user.id, movie_id: params[:movie_id]).first
    if @like.nil?
      @like = Like.create(user_id: current_user.id, movie_id: params[:movie_id])
    else
      @like.destroy
    end
    # frozen 일 경우 
    # @like.frozen?
  end

  ### 여기서부터 private
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      # params.fetch(:movie, {})
      # 허락된 column만 params로 넘길 수 있게 whitelist를 만들어준다.
      params.require(:movie).permit(:title, :genre, :director, :actor, :description, :image_path)
    end
end
