module Api
  module V1
    module Users
      class RegistrationsController < Devise::RegistrationsController
        # Disable CSRF protection
        skip_before_action :verify_authenticity_token

        # Should only response to JSON requests
        respond_to :json

        # before_action :configure_sign_up_params, only: [:create]
        # before_action :configure_account_update_params, only: [:update]

        # GET /resource/sign_up
        # def new
        #   super
        # end

        # POST /resource
        def create
          # This is the default behavior from the devise sessions controller source,
          # except for what is rendered.
          # github.com/plataformatec/devise/blob/master/app/controllers/devise/registrations_controller.rb
          build_resource(sign_up_params)

          resource.save
          yield resource if block_given?
          if resource.persisted?
            if resource.active_for_authentication?
              set_flash_message! :notice, :signed_up
              sign_up(resource_name, resource)
              # This is the original last line in the devise sessions controller source
              # respond_with resource, location: after_sign_up_path_for(resource)

              # This is custom behavior. Respond by rendering User Presenter.
              render json: payload(resource), status: :created
            else
              set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
              expire_data_after_sign_in!
              respond_with resource, location: after_inactive_sign_up_path_for(resource)
            end
          else
            clean_up_passwords resource
            set_minimum_password_length
            respond_with resource
          end
        end

        # GET /resource/edit
        # def edit
        #   super
        # end

        # PUT /resource
        # def update
        #   super
        # end

        # DELETE /resource
        # def destroy
        #   super
        # end

        # GET /resource/cancel
        # Forces the session data which is usually expired after sign
        # in to be expired now. This is useful if the user wants to
        # cancel oauth signing in/up in the middle of the process,
        # removing all OAuth session data.
        # def cancel
        #   super
        # end

        # protected

        # If you have extra params to permit, append them to the sanitizer.
        # def configure_sign_up_params
        #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
        # end

        # If you have extra params to permit, append them to the sanitizer.
        # def configure_account_update_params
        #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
        # end

        # The path used after sign up.
        # def after_sign_up_path_for(resource)
        #   api_v1_user_path
        # end

        # The path used after sign up for inactive accounts.
        # def after_inactive_sign_up_path_for(resource)
        #   super(resource)
        # end
      end
    end
  end
end
