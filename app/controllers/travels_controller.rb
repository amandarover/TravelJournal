class TravelsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def new
  end

  def create
    # binding.pry
    render plain: params[:travel].inspect
  end
end
