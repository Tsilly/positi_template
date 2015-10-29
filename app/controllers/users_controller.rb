class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def show ; end

  def create
    @user = User.new(params_user)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Your've' successfully signed up."
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def edit ;  end

  def update
    if @user.update(params_user)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private
  def params_user
    params.require(:user).permit(:username, :password, :time_zone)
  end
  def find_user
    @user = User.find_by(slug: params[:id])
  end
end