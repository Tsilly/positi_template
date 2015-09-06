class PostsController < ApplicationController
	before_action :find_post, only: [:show, :edit, :update]
	
	def index
		@posts = Post.all
	end

	def show 
		@comment = @post.comments.new
		
	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(params_post)
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

	private
		def params_post
			params.require(:post).permit(:title, :url, :description, category_ids: [])
		end

		def find_post
			@post = Post.find(params[:id])
		end
end
