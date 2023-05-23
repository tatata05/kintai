# frozen_string_literal: true

class Employees::SessionsController < Devise::SessionsController
  before_action :logged_out_admin, only: [:new, :create]
  # before_action :configure_sign_in_params, only: [:create]

  def after_sign_in_path_for(resource)
    employee_shifts_path
  end

  def guest_employee_sign_in
    employee = Employee.guest
    sign_in employee
    redirect_to employee_shifts_path, notice: 'ゲスト従業員としてログインしました。'
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
