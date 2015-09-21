class CategoriesController < ApplicationController
  before_action :find_category, only: [:show, :edit, :update]
  before_action :require_user, except: [:index, :show]
  
  def index
    @categories = Category.all
  end
  def show 
    @posts = @category.posts.all
  end
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params_category)
    if @category.save
      flash[:notice] = "#{@category.name} is saved."
      redirect_to categories_path
    else
      render :new
    end
  end
  def edit ;end
  def update
    if @category.update(params_category)
      flash[:notice] = "#{@category.name} is updated"
      redirect_to categories_path
    else
      render :edit
    end
  end

  private 
  def find_category
    @category = Category.find(params[:id])
  end
  def params_category 
    params.require(:category).permit(:name)
  end
end
