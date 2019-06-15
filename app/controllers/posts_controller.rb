class PostsController < ApplicationController
  before_action :set_post, only: [ :add_comment ]
  skip_before_action :verify_authenticity_token

  def create
  end

  def update
  end

  def index
  end

  def show
  end

  def destroy
  end

  def add_comment
    @comment = Comment.create(nickname: User.find(comment_params[:user_id].nickname, comment: comment_params[:comment], post: Post.find(comment_params[:post_id])))
    if @comment.save
      render :index
    else
      render :json => { :errors => @comment.errors.full_messages }
    end
  end

  private

  def set_post
    @post = Post.find(post_params[:id])
  end

  def post_params
    params.require(:post).permit(:user_id, :description, :capacity, :location, :contact_number, :is_full, :id)
  end

  def comment_params
    params.require(:comment).permit(:comment, :post_id, :user_id)
  end
end
