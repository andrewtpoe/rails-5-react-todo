require "rails_helper"

module Api
  module V1
    module Users
      RSpec.describe RegistrationsController do

        before do
          # This is required because we are bypassing the router to test custom
          # logic in the devise controller methods
          @request.env["devise.mapping"] = Devise.mappings[:user]
        end

        describe "#create" do
          context "with an email that doesn't belong to an existing user" do
            context "and valid login params" do
              let(:params) {{
                user: {
                  email: "unique_email@gmail.com",
                  password: "password"
                },
                format: :json
              }}

              it "creates a new user" do
                expect {
                  post :create, params: params
                }.to change {
                  User.count
                }.by 1
              end

              it "signs in the user" do
                post :create, params: params
                user = User.find_by(email: "unique_email@gmail.com")
                expect(user.current_sign_in_at).to be_truthy
              end

              it "returns a status 201" do
                post :create, params: params
                expect(response).to have_http_status 201
              end

              it "initializes user presenter and renders the value of .to_json" do
                user_presenter_mock = double Api::V1::UserPresenter
                successful_response = { status: "success" }.to_json

                expect(Api::V1::UserPresenter)
                  .to receive(:new)
                  .and_return(user_presenter_mock)
                expect(user_presenter_mock)
                  .to receive(:to_json)
                  .and_return(successful_response)

                post :create, params: params

                expect(response.body).to eq successful_response
              end
            end

            context "and invalid login parameter" do
              context "email" do
                let(:params) {{
                  user: {
                    email: "bad",
                    password: "password"
                  },
                  format: :json
                }}

                it "does not create a user" do
                  expect {
                    post :create, params: params
                  }.not_to change {
                    User.count
                  }
                end

                it "returns an error with a status 422" do
                  post :create, params: params
                  expect(response).to have_http_status 422
                  body = JSON.parse(response.body).with_indifferent_access
                  expect(body[:errors][:email]).to eq ["is invalid"]
                end
              end

              context "password" do
                let(:params) {{
                  user: {
                    email: "good@email.com",
                    password: "almost"
                  },
                  format: :json
                }}

                it "does not create a user" do
                  expect {
                    post :create, params: params
                  }.not_to change {
                    User.count
                  }
                end

                it "returns an error with a status 422" do
                  post :create, params: params
                  expect(response).to have_http_status 422
                  body = JSON.parse(response.body).with_indifferent_access
                  expect(body[:errors][:password]).to eq ["is too short (minimum is 8 characters)"]
                end
              end
            end
          end

          context "with an existing user" do
            let!(:user) { User.create(email: "first@gmail.com", password: "password") }

            context "and valid login params" do
              let(:params) {{
                user: {
                  email: user.email,
                  password: "password"
                },
                format: :json
              }}

              it "does not sign in the user" do
                post :create, params: params
                user.reload
                expect(user.current_sign_in_at).to be_falsy
              end

              it "renders an error with a status 422" do
                post :create, params: params
                expect(response).to have_http_status 422
                body = JSON.parse(response.body).with_indifferent_access
                expect(body[:errors][:email]).to eq ["has already been taken"]
              end
            end

            context "and invalid login params" do
              let(:params) {{
                user: {
                  email: user.email,
                  password: "wrong_password"
                },
                format: :json
              }}

              it "does not sign in the user" do
                post :create, params: params
                user.reload
                expect(user.current_sign_in_at).to be_falsy
              end

              it "returns an error with a status 422" do
                post :create, params: params
                expect(response).to have_http_status 422
                body = JSON.parse(response.body).with_indifferent_access
                expect(body[:errors][:email]).to eq ["has already been taken"]
              end
            end
          end
        end
      end
    end
  end
end
