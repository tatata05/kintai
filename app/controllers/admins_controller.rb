class AdminsController < ApplicationController
  before_action :logged_in_admin, only: [:home, :index, :show]

  def home
  end

  def index
    @admins = Admin.all
  end

  def show
    @admin = Admin.find_by(id: params[:id])
  end

  private

  def logged_in_admin
    return if admin_signed_in?
    flash[:danger] = "管理者としてログインしてください"
    redirect_to root_path
  end
end
