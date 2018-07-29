class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def js_authenticate_user!
    render js: "location.href='/users/sign_in';" unless user_signed_in?
    
    # render js: "alert('로그인 하고 오셈');"
    # render js: "alert('로그인 하고 오셈');" unless user_signed_in?
  end
end
