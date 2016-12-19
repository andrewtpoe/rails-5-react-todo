class WelcomeController < ApplicationController
  before_action :authenticate_request!
  def index
    # authenticate_request!
    # if authenticate_request!
      render json: {logged_in: 'true'}
    # end
  end
end
