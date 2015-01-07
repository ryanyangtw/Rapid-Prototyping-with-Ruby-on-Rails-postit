class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]

  def index
    @category = Category.all
  end

  def show; end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category was created"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:notice] = "Category was updated"
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def set_category
    @category = Category.find_by( slug: params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end

end