class AuthenticationController < Api::V1::BaseController
  def authenticate_user
    user = User.find_for_database_authentication(email: params[:email])
    if user.valid_password?(params[:password])
      render json: payload(user)
    else
      render json: { errors: ['Invalid Username / Password'] }, status: unauthorized
    end
  end
end
