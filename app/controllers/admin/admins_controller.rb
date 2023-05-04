class Admin::AdminsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @admins = Admin.all
  end

  def show
    @admin = Admin.find_by(id: params[:id])
  end
end
