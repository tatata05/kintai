class Admin::AdminsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @admins = Admin.search(params[:search]).page(params[:page]).per(10)
  end

  def show
    @admin = Admin.find_by(id: params[:id])
  end
end
