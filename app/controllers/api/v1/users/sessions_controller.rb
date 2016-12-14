module Api
  module V1
    module Users
      class SessionsController < Devise::SessionsController
        # Disable CSRF protection
        skip_before_action :verify_authenticity_token

        # Should only response to JSON requests
        respond_to :json

        # before_action :configure_sign_in_params, only: [:create]

        # GET /resource/sign_in
        # def new
        #   super
        # end

        # POST /resource/sign_in
        def create
          # This is the default behavior from the devise sessions controller source,
          # except for what is rendered.
          # github.com/plataformatec/devise/blob/master/app/controllers/devise/sessions_controller.rb
          self.resource = warden.authenticate!(auth_options)
          set_flash_message!(:notice, :signed_in)
          sign_in(resource_name, resource)
          yield resource if block_given?
          # This is the original last line in the devise sessions controller source
          # respond_with resource, location: after_sign_in_path_for(resource)

          # This is custom behavior.
          render json: payload(resource), status: :created
        end

        # DELETE /resource/sign_out
        # def destroy
        #   super
        # end

        # protected

        # If you have extra params to permit, append them to the sanitizer.
        # def configure_sign_in_params
        #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
        # end
      end
    end
  end
end
