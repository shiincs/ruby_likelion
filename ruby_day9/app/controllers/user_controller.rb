class UserController < ApplicationController
  def index
    @users = User.all
    # session에 uid가 들어있다면 find를 수행하고, 아니면 수행 안함
    @login_user = User.find(session[:uid]) if session[:uid]
  end
  
  def new
  end
  
  def create
    user = User.new
    user.uid = params[:uid]
    user.password = params[:pwd]
    user.ip_address = request.ip
    user.save
    redirect_to "/user/#{user.id}"
  end
  
  def sign_in
    #로그인 되어있는지 확인하고,
    #로그인 되어있으면 원래 페이지로 돌아가기
  end
  
  def logout
    session.delete(:uid)
    flash[:success] = "로그아웃에 성공했습니다."
    redirect_to "/users"
  end
  
  def login
    # 유저가 입력한 ID, PW를 바탕으로 실제로 로그인이 이루어지는 곳
    id = params[:uid]
    pw = params[:pwd]
    user = User.find_by_uid(id)
    
    # 해당 uid로 가입한 유저가 있고, 패스워드도 일치하는 경우
    if !user.nil? and user.password.eql?(pw)
      session[:uid] = user.id
      flash[:success] = "로그인에 성공했습니다."
      redirect_to "/users"
    # 가입한 uid가 없거나, 패스워드가 틀린 경우
    else
      flash[:error] = "가입된 유저가 아니거나, 비밀번호가 틀립니다."
      redirect_to "/sign_in"
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    user = User.find(params[:id])
    # user.uid = params[:uid]
    user.password = params[:pwd]
    user.save
    redirect_to "/user/#{user.id}"
  end
  
end
