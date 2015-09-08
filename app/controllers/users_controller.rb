class UsersController < ApplicationController
	before_action :find_user, only: [:show, :edit, :create]
	def new
		@user = User.new
	end

	def show ; end

	def create
		@user = User.new(params_user)
		if @user.save
			flash[:notice] = "Your've' successfully signed up."
			redirect_to root_path
		else
			render :new
		end
	end

	def edit ;	end

	def update
		if @user.update(params_user)
			redirect_to user_path
		else
			render :edit
		end
	end

	private
	def params_user
		params.require(:user).permit(:username, :password)
	end
	def find_user
		@user = User.find(params[:id])
	end
end