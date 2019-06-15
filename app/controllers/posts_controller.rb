class PostsController < ApplicationController
  before_action :set_post, only: [ :add_comment ]

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
    @comment = Comment.create(nickname: User.find(params[:user_id].nickname, comment: params[:comment], post: @post))
    if @comment.save
      render :index
    else
      render :json => { :errors => @comment.errors.full_messages }
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:user_id, :description, :capacity, :location, :contact_number, :is_full)
  end

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
