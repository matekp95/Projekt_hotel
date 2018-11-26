class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params['user']['user_role'] = 'user'
    params.require(:user).permit(:first_name, :last_name, :email, :user_role, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :user_role, :password_confirmation, :current_password)
  end
end
