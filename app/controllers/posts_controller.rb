class PostsController < ApplicationController
  before_action :set_post, only: [:vote, :show, :edit, :update, :destroy]
  before_action :require_user, except:[:index, :show]

  def index
    @posts = Post.all
    #expires_in 999999999999, piblic: true
    fresh_when @products, public: true
  end
  
  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    #@post.creator = User.first #TODO: change once we have authentication
    @post.creator = current_user
    if @post.save 
      flash[:notice] = 'You post was created'
      redirect_to posts_path
    else
      render :new
    end

  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "The post was updated"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
  end

  def vote

    @vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])
    if @vote.valid?
      flash[:notice] = 'Your vote was counted.'
    else
      flash[:error] = 'You can only vote on a post once.'
    end
    redirect_to :back
  end

  
  private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end
end
