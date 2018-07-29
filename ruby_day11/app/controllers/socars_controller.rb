class SocarsController < ApplicationController
  before_action :set_socar, only: [:show, :edit, :update, :destroy]
  
  def index
    @socars = Socar.all
  end

  def show
    # @socar = Socar.find(params[:id])
  end
  
  def new
  end

  def create
    @socar = Socar.new(title: params[:title], contents: params[:contents])
    if @socar.save
      redirect_to "/socars/#{@socar.id}"
    else
      redirect_to :back #직전화면으로 돌아간다
    end
  end

  def edit
    # @socar = Socar.find(params[:id])
  end
  
  def update
    if @socar.update(socar_params)
      redirect_to "/socars/#{@socar.id}"
    else
      redirect_to :back
    end
  end
  
  def destroy
    @socar.destroy
    redirect_to "/socars"
  end
  
  def set_socar
    @socar = Socar.find(params[:id])
  end
  
  def socar_params
    {
      title: params[:title], 
      contents: params[:contents],
    }
  end
end
