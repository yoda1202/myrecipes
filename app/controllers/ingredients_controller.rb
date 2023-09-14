class IngredientsController < ApplicationController
  before_action :set_ingredient, only: [:edit, :update, :show]
  before_action :require_admin, except: [:show, :index]

  def new
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      flash[:success] = "食材を作成しました"
      redirect_to ingredient_path(@ingredient)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit

  end

  def update
    if @ingredient.update(ingredient_params)
      flash[:success] = "食材を編集しました"
      redirect_to @ingredient
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def show
    @ingredient_recipes = @ingredient.recipes.paginate(page: params[:page], per_page: 5)
  end

  def index
    @ingredients = Ingredient.paginate(page: params[:page], per_page: 5)
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:name)
  end

  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
  end

  def require_admin
    if !logged_in? || (logged_in? and !current_chef.admin?)
      flash[:danger] = "管理者のみ実行可能です"
      redirect_to ingredients_path
    end
  end

end