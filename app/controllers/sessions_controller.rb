class SessionsController < ApplicationController

  def new

  end

  def create
    chef = Chef.find_by(email: params[:session][:email].downcase)
    if chef && chef.authenticate(params[:session][:password])
      session[:chef_id] = chef.id
      flash[:success] = "ログインしました"
      redirect_to chef
    else
    flash.now[:danger] = "メールアドレスまたはパスワードが間違っています"
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    session[:chef_id] = nil
    flash[:success] = "ログアウトしました"
    redirect_to root_path, status: :see_other
  end

end