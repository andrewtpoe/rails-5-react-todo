module Api
  module V1
    class UsersController < Api::V1::BaseController

      def show
        user_presenter = Api::V1::UserPresenter.new(current_user)
        render json: user_presenter.to_json
      end
    end
  end
end
