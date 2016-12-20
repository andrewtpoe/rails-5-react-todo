module Api
  module V1
    class WelcomeController < BaseController
      before_action :authenticate_request!
      def index
        render json: {logged_in: 'true'}
      end
    end
  end
end
