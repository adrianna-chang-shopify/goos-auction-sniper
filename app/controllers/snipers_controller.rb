class SnipersController < ApplicationController
  def new
    @sniper = Sniper.new
  end

  def create
    @sniper = Sniper.new(sniper_params)

    if @sniper.save
      redirect_to snipers_path
    else
      render :new
    end
  end

  def index
    @snipers = Sniper.all
  end

  def callback
    raise "not done"
  end

  private

  def sniper_params
    params.require(:sniper).permit(:item_id)
  end
end
