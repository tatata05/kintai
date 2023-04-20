class AdminsController < ApplicationController
  def home
  end

  def index
    @admins = Admin.all
  end
end
