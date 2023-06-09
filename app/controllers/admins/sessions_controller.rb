# frozen_string_literal: true

class Admins::SessionsController < Devise::SessionsController
  before_action :logged_out_employee, only: [:new, :create]
  # before_action :configure_sign_in_params, only: [:create]

  def after_sign_in_path_for(resource)
    admin_home_path
  end

  def guest_admin_sign_in
    admin = Admin.guest
    sign_in admin
    redirect_to admin_home_path, notice: 'ゲスト管理者としてログインしました。'
  end

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

  def logged_out_employee
    return unless employee_signed_in?

    flash[:danger] = "管理者としてログインするには、先に従業員アカウントからログアウトしてください"
    redirect_to employee_shifts_path
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
