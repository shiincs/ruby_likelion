class TestsController < ApplicationController
  before_action :set_test, only: [:show, :edit, :update, :destroy]
  def index
    @tests = Test.all
  end
  
  def new
  end
  
  def create
    # test = Test.new
    # test.title = params[:title]
    # test.contents = params[:contents]
    # test.save
    test = Test.create(test_params)
    redirect_to "/test/#{test.id}"
  end
  
  def show
    # @test = Test.find(params[:id])
  end
  
  def edit
    # @test = Test.find(params[:id])
  end
  
  def update
    # test = Test.find(params[:id])
    # test.title = params[:title]
    # test.contents = params[:contents]
    # test.save
    @test.update(test_params)
    redirect_to "/test/#{@test.id}"
  end
  
  def destroy
    # test = Test.find(params[:id])
    @test.destroy
    redirect_to "/tests"
  end
  
  def set_test
    @test = Test.find(params[:id])
  end
  
  def test_params
    {
      title: params[:title],
      contents: params[:contents],
    }
  end

end