class PostsController < ApplicationController
  def show
    @post = Post.find_by(id: params[:id])
    render :show
  end

  def new
    @post = Post.new
    @sub_from_id 

    if params[:sub_id]
      @from_sub_id = params[:sub_id]
    end

    render :new
  end

  def create
    debugger
    @post = Post.new(post_params)
    @post.author_id = current_user.id

    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end
  
  private
  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end
end
