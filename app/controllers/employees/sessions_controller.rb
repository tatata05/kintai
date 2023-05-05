# frozen_string_literal: true

class Employees::SessionsController < Devise::SessionsController
  before_action :logged_out_admin, only: [:new]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def logged_out_admin
    return unless admin_signed_in?

    flash[:danger] = "従業員としてログインするには、先に管理者アカウントからログアウトしてください"
    redirect_to admin_home_path
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
