class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ edit update destroy ]

  # GET /categories or /categories.json
  def index
    @categories = Category.all.order(name: :asc)
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories or /categories.json
  def create
    @category = Category.new(category_params)
    
    if @category.save
      redirect_to categories_url, notice: 'categoria creada'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    if @category.update(category_params)
      redirect_to categories_url, notice: 'categoria modificada'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @category.destroy

    redirect_to categories_url, notice: 'categoria eliminada'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name)
    end
end
