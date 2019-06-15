class PostsController < ApplicationController
  before_action set_post, only: [:show]

  def create
    @post = Post.new(post_params)
    if @post.save
      render :show, status: :created
    else
      render_error
    end
  end

  def update
    if @post.update(post_params)
      render :show
    else
      render_error
    end
  end

  def index
    @posts = Post.all
  end

  def show
  end

  def destroy
    @post.destroy
    head :no_content
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:description, :capacity, :location, :contact_number, :is_full, :language, :user_id)
  end
end
