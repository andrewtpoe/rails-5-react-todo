# This module is a base class for the presenters.
module Api
  module V1
    class BasePresenter

      # converts the presenter's .to_hash method to a json string
      #
      # @return [String]
      def to_json
        to_hash.to_json
      end
    end
  end
end
