class SearchController < ApplicationController
  def search
    @posts = []
    unless params[:q].blank?
     @response = Post.search params[:q]
     @response.records.map { |post| @posts << post } 
     @unique_posts = @posts.uniq!
     @posts = @unique_posts if !@unique_posts.nil? 
    end

    @query = params[:q]
  end
end
