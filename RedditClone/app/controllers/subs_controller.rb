class SubsController < ApplicationController
  before_action :is_moderator?, only: [:edit, :update]
  
  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find_by(id: params[:id])
    @posts = Post.where("? IN posts.sub_ids", params[:id]) # Not working?

    render :show
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id # Is this the correct way to assign moderator_id?

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    render :edit # edit form should have access to @sub from #is_moderator?
  end

  def update
    @sub = Sub.find(params[:id]) # At this point we know the sub exists, because the edit form was shown for it.  Technically redundant because #is_moderator was executed.

    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end


  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def is_moderator?
    @sub = Sub.find_by(id: params[:id])

    unless current_user.id == @sub.moderator_id
      flash[:errors] = ["Must be moderator to edit the sub"]
      redirect_to sub_url(sub) 
    end
  end
end
