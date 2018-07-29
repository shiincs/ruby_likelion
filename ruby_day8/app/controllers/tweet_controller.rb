class TweetController < ApplicationController
    def index
        @boards = Board.all
        cookies[:user_name] = "CS"
    end
    
    def new
    end
    
    def create
        boards = Board.new
        boards.contents = params[:content]
        boards.ip_address = request.ip
        boards.region = request.location.region
        boards.save
        flash[:success] = "새 글이 등록되었습니다."
        redirect_to "/tweets"
    end
    
    def show
        @content = Board.find(params[:id])
    end
    
    def edit
        @board = Board.find(params[:id])
    end
    
    def update
        boards = Board.find(params[:id])
        boards.contents = params[:content]
        boards.save
        flash[:success] = "수정이 완료되었습니다."
        redirect_to "/tweet/#{boards.id}"
    end
    
    def delete
        boards = Board.find(params[:id])
        boards.destroy
        flash[:error] = "글이 삭제되었습니다."
        redirect_to "/tweets"
    end
end
