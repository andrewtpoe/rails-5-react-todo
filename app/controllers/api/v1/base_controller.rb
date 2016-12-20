module Api
  module V1
    class BaseController < ApplicationController
      protect_from_forgery unless: -> { request.format.json? }

      private
      def authenticate_user
        user = User.find_for_database_authentication(email: params[:user][:email])
        if user.valid_password?(params[:user][:password])
          render json: payload(user)
        else
          render json: { errors: ['Invalid Username / Password'] }, status: unauthorized
        end
      end

      def authenticate_request!
        unless user_id_in_token?
          render json: { errors: ['Not Authenticated No User ID In Token'] }, status: :unauthorized
          return
        end
        @current_user = User.find(auth_token[:user_id])
      rescue JWT::VerificationError, JWT::DecodeError
        render json: { errors: [auth_token] }, status: :unauthorized
      end


      def http_token
        if request.headers["HTTP_AUTHORIZATION"].present?
          request.headers["HTTP_AUTHORIZATION"].split(' ').last
        end
      end

      def auth_token
        JsonWebToken.decode(http_token)
      end

      def user_id_in_token?
        http_token && auth_token && auth_token[:user_id].to_i
      end

      def payload(user)
        return nil unless user and user.id
        {
          auth_token: JsonWebToken.encode({ user_id: user.id }),
          user: { id: user.id, email: user.email }
        }
      end
    end
  end
end
