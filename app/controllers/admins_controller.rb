class AdminsController < ApplicationController
  def home
  end

  def index
    @admins = Admin.all
  end

  def show
    @admin = Admin.find_by(id: params[:id])
  end
end
