class ChefsController < ApplicationController
  before_action :set_chef, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]

  def index
    @chefs = Chef.paginate(page: params[:page], per_page: 5)
  end

  def new
    @chef = Chef.new
  end

  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      session[:chef_id] = @chef.id
      flash[:success] = "#{@chef.chefname}シェフ、MyRecipesにようこそ!"
      redirect_to chef_path(@chef)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @chef_recipes = @chef.recipes.paginate(page: params[:page], per_page: 5)
  end

  def edit
  end

  def update
    if @chef.update(chef_params)
      flash[:success] = "更新しました"
      redirect_to @chef
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    if !@chef.admin?
      @chef.destroy
      flash[:danger] = "削除しました"
      redirect_to chefs_path
    end
  end

  private

  def chef_params
    params.require(:chef).permit(:chefname, :email, :password, :password_confirmation)
  end

  def set_chef
    @chef = Chef.find(params[:id])
  end

  def require_same_user
    if current_chef != @chef and !current_chef.admin?
      flash[:danger] = "自身のアカウントのみ編集、削除できます"
      redirect_to chefs_path
    end
  end

  def require_admin
    if logged_in? & !current_chef.admin?
      flash[:danger] = "管理者のみ実行可能です"
      redirect_to root_path
    end
  end

end