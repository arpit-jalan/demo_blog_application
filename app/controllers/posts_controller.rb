class PostsController < ApplicationController
  def index
    if params[:user_id].present?
      @posts = Post.where(:user_id => params[:user_id].to_i)
    else
      @posts = Post.all
    end

  	respond_to do |format|
  		format.html
  		format.json {render json: @posts}
  	end
  end

  def show
  	@post = Post.find(params[:id])
  	respond_to do |format|
		format.html
		format.json {render json: @post}
	  end
  end

  def new

    user = User.find(params[:user_id])
    authorize! :new, user

  	@post = Post.new
    @user_id = params[:user_id]


  	respond_to do |format|
  		format.html
  		format.json {render json:@post}
  	end
  end

  def edit
    user = User.find(params[:user_id])
    authorize! :edit, user
    @post = Post.find(params[:id])
  end

  def create
  	@post = Post.new(params[:post])
  	respond_to do |format|
  		if @post.save
        	format.html { redirect_to @post}
        	format.json { render json: @post, status: :created, location: @post }
      	else
          @user_id = current_user.id
        	format.html { render action: "new" }
        	format.json { render json: @post.errors, status: :unprocessable_entity }
      	end
  	end
  end

  def update

  	@post = Post.find(params[:id])


  	respond_to do |format|
  		if @post.update_attributes(params[:post])
  			format.html {redirect_to @post, notice: 'Updated successfully.'}
  			format.json {head :no_content}
  		else
  			format.html { render action: "edit" }
        	format.json { render json: @post.errors, status: :unprocessable_entity }
      	end	
  	end
  end

  def destroy


    user = User.find(params[:user_id])
    authorize! :destroy, user

  	@post = Post.find(params[:id])


  	@post.destroy

  	respond_to do |format|
    	format.html { redirect_to users_url }
    	format.json { head :no_content }
    end
  end
end
