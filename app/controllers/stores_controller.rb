class StoresController < ApplicationController
  def index
    @stores = Store.all
  end

  def show
    @store = Store.includes(:beans).find(params[:id])
  end
end
