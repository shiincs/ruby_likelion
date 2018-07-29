class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # helper_method를 사용해 컨트롤러의 메소드를 뷰로 넘겨서 사용한다.
  helper_method :user_signed_in?
  
  # 현재 로그인 된 상태니?
    # 로그인 되어 있지 않으면 로그인하는 페이지로 이동시켜줘
  def authenticate_user! # 의도하지 않은 액션이 발생할 수 있는 메서드에 ! 붙인다
    unless user_signed_in?
      redirect_to '/sign_in'
    end
  end
    
  def user_signed_in? # 리턴값이 true/false 일 경우 ? 붙인다
    session[:uid].present?
  end
  
  # 현재 로그인 된 사람이 누구니?

  def current_user
    # 현재 로그인 됐니?
    if user_signed_in?
      # 됐다면 로그인한 사람은 누구니?
      @current_user = User.find(session[:uid])
    end
  end
  
end
