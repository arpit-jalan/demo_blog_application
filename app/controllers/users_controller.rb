require 'will_paginate/array'
class UsersController < ApplicationController

	before_filter :authenticate_user!, :except => [:index]

	def index
		@users = User.paginate(:page => params[:page], :per_page => 12)

		respond_to do |format|
			format.html
			format.json {render json:@users}
		end
	end

	def show
	@user = User.find(params[:id])
	@posts = @user.posts
	authorize! :show, @user

		respond_to do |format|
			format.html
			format.json {render json: @user}
		end
	end

	def new
			@user = User.new
			respond_to do |format|
				format.html
				format.json {render json:@user}
			end
	end

		def edit
			@user = User.find(params[:id])
			authorize! :edit, @user
	end

	def create
		@user = User.new(params[:user])

		respond_to do |format|
			if @user.save
				UserMailer.welcome_email(@user).deliver_now
				format.html { redirect_to @user, notice: 'User was successfully created.' }
				format.json { render json: @user, status: :created, location: @user }
			else
				format.html { render action: "new" }
				format.json { render json: @user.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		@user = User.find(params[:id])
		authorize! :update, @user

		respond_to do |format|
			if @user.update_attributes(params[:user])
				format.html {redirect_to @user}
				format.json {head :no_content}
			else
				format.html { render action: "edit" }
				format.json { render json: @user.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@user = User.find(params[:id])
		authorize! :destroy, @user
		@user.destroy

		respond_to do |format|
			format.html { redirect_to users_url }
			format.json { head :no_content }
		end
	end
end