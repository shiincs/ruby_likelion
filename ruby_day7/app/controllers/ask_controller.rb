class AskController < ApplicationController
    def index
        # @contents = Ask.all
        @asks = Ask.all
    end
    
    def new
        #p request.ip   # p는 내용물도 다 보여준다.
        #p request.location.region
    end
    
    def create
        # question = params[:question]
        # ask = Ask.new
        # ask.question = question
        # ask.save
        ask = Ask.new
        ask.question = params[:q]
        ask.ip_address = request.ip
        ask.region = request.location.region
        ask.save
        redirect_to "/ask"
    end
    
    def delete
        ask = Ask.find(params[:id])
        ask.destroy
        redirect_to "/ask"
    end
    
    def edit
        @ask = Ask.find(params[:id])
    end
    
    def update
        ask = Ask.find(params[:id])
        ask.question = params[:q]
        ask.save
        redirect_to "/ask"
    end
    
    def show
       @ask = Ask.find(params[:id]) 
    end
    
end
