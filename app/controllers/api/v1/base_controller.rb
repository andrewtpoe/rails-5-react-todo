module Api
  module V1
    class BaseController < ApplicationController
      protect_from_forgery unless: -> { request.format.json? }

      # before_action :authenticate_user!
    end
  end
end
