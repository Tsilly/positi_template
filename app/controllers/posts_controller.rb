class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show]
  before_action :require_creator, only: [:edit, :update]
  
  def index
    @posts = Post.all.sort_by{|x| x.total_votes}.reverse
  end

  def show 
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params_post)
    @post.user = current_user
    if @post.save
      flash[:notice] = "Your post is saved."
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit ;end

  def update
    if @post.update(params_post)
      flash[:notice] = "Your post is updated."
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def vote
    # @post = Post.find(params[:id]) -> see before_action :find_post, only: [..., :vote]
    @vote = Vote.create(voteable: @post, user: current_user, vote: params[:vote])

    respond_to do |format|
      format.html do
        if @vote.valid? #vote is counted
          flash[:notice] = "Your vote was counted."
        else
          flash[:error] = "You can only vote on a comment once."
        end
        redirect_to :back
      end
      format.js
    end
  end

  private
    def params_post
      params.require(:post).permit(:title, :url, :description, category_ids: [])
    end

    def find_post
      @post = Post.find_by(slug: params[:id])
    end

    def require_creator
      access_denied unless logged_in? and (current_user.id == @post.user_id || current_user.admin?)
    end
end
