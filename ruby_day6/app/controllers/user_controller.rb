class UserController < ApplicationController
    def index
        @users = User.all # User 클래스 전체를 @users에 담아라
    end

    def new
    end
    
    def create
        u1 = User.new
        u1.user_name = params[:user_name]
        u1.password = params[:password]
        u1.save
        redirect_to "/user/#{u1.id}"
    end
    
    def show
        @user = User.find(params[:id])
    end
end
