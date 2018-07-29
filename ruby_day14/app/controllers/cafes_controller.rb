class CafesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  # 전체 카페 목록 보여주는 페이지
  def index
    @cafes = Daum.all
    # if user_signed_in?
    #   @cafes = current_user.daums
    # else
    #   @cafes = Daum.all
    # end
  end
  
  # -> 로그인 했을 때 / 로그인 하지 않았을 때 구분해서 보여줌
  # -> 로그인 하지 않았을 때: 전체 카페 목록
  # -> 로그인 했을 때: 유저가 가입한 카페 목록
  
  # 카페 내용물을 보여주는 show 페이지(이 카페의 게시물)
  def show
    @cafe = Daum.find(params[:id])
    # session[:current_cafe] = @cafe.id
  end
  
  # 카페를 개설하는 페이지
  def new
    @cafe = Daum.new
  end
  
  # 카페를 실제로 개설하는 로직
  def create
    @cafe = Daum.new(daum_params)
    @cafe.master_name = current_user.user_name
    if @cafe.save
      #카페를 만들고, 만든 사람이 카페에 가입된다.
      Membership.create(daum_id: @cafe.id, user_id: current_user.id)
      # cafe_path에 @cafe 객체의 id를 찾아서 넘긴다.
      redirect_to cafe_path(@cafe), flash: {success: "카페가 개설되었습니다."}
    else
      p @cafe.errors
      redirect_to :back, flash: {danger: "카페 개설에 실패했습니다."}
    end
  end
  
  def join_cafe
    # 사용자가 가입하려는 카페
    cafe = Daum.find(params[:cafe_id])
    # 이 카페에 현재 로그인된 사용자가 가입이 됐는지 체크
    # if cafe.users.include? current_user
    if cafe.is_member? (current_user)
      # 가입 실패
      redirect_to :back, flash: {danger: "이미 가입된 카페입니다."}
    else
      # 가입 성공
      Membership.create(daum_id: params[:cafe_id], user_id: current_user.id)
      redirect_to :back, flash: {success: "카페 가입에 성공했습니다."}
    end
    # 중복가입을 막을 수 없음
    # 1. 가입버튼을 안보이게 한다. (사용자 화면 조작) -> Model 코딩(메서드)
    # 2. 중복 가입 체크 후 진행 (서버에서 로직 조작) -> Model Validation
    # 현재 이 카페에 가입된 유저 중에 지금 로그인한 유저가 있니?
  end
  
  # 카페 정보 수정하는 페이지
  def edit
  end
  
  # 카페 정보를 실제로 수정하는 로직
  def update
  end
  
  private # private이 한번 선언되면 그 밑의 action은 모두 private으로 생성됨
  def daum_params
    params.require(:daum).permit(:title, :description)
    # :params => {:daum => {:title => "...", :description => "..."}}
  end
end
