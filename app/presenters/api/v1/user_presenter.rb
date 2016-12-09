module Api
  module V1
    class UserPresenter < Api::V1::BasePresenter

      def initialize(user)
        @user = user
      end

      def to_hash
        {
          attributes: {
            email: user.email,
          },
          type: "user"
        }
      end

      private

      attr_reader :user
    end
  end
end
