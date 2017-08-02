require 'will_paginate/array'
class HomeController < ApplicationController
  def index
  	@posts = Post.paginate(:page => params[:page], :per_page => 6)
  	respond_to do |format|
  		format.html
  		format.json {render json: @posts}
  	end
  end
end
