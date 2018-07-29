class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  # 뷰에서 메서드를 사용하기 위해 헬퍼메서드에 설정
  helper_method :user_signed_in?, :current_user
  
  def user_signed_in? # ?가 있다면 true or false return
    session[:sign_in_user].present?
  end
  
  def authenticate_user! # !가 있다면 사용자가 요청한 페이지가 원하는대로 동작하지 않을 수 잇음
    redirect_to sign_in_path unless user_signed_in?
  end
  
  def current_user
    # 유저가 로그인 되어 있을 때만 session 정보 찾아서 @current_user 생성
    @current_user = User.find(session[:sign_in_user]) if user_signed_in?
  end
end
