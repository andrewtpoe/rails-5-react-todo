module Api
  module V1
    class BaseController < ApplicationController
      protect_from_forgery unless: -> { request.format.json? }

    end
  end
end
