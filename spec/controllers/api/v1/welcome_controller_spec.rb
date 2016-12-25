require "rails_helper"

module Api
  module V1
    RSpec.describe WelcomeController do
      describe '#index' do
        context 'when JWT is incorrect' do
          let(:not_authenticated_response) {["Not Authenticated No User ID In Token"]}
          context 'when no Authorization Header is received' do
            before do
              get :index
            end
            it 'returns status unauthorized' do
              expect(response).to have_http_status 401
            end
            it 'returns an error' do
              body = JSON.parse(response.body).with_indifferent_access
              expect(body['errors']).to eq(not_authenticated_response)
            end
          end

          context 'when the JWT has invalid secret' do
            before do
              @request.headers['Authorization'] = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.__axIF2iO7Ng_Z9DZ-XnGyrjpdELL4X5OOsQ-xSn-ho'
              get :index
            end
            it 'returns status unauthorized' do
              expect(response).to have_http_status 401
            end
            it 'returns an error response' do
              body = JSON.parse(response.body).with_indifferent_access
              expect(body['errors']).to eq(not_authenticated_response)
            end
          end

          context 'when the JWT has invalid claim' do
            before do
              @request.headers['Authorization'] = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfz.__axIF2iO7Ng_Z9DZ-XnGyrjpdELL4X5OOsQ-xSn-bo'
              get :index
            end
            it 'returns status unauthorized' do
              expect(response).to have_http_status 401
            end
            it 'returns an error response' do
              body = JSON.parse(response.body).with_indifferent_access
              expect(body['errors']).to eq(not_authenticated_response)
            end
          end

          context 'when the JWT header does not contain Bearer' do
            before do
              @request.headers['Authorization'] = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfz.__axIF2iO7Ng_Z9DZ-XnGyrjpdELL4X5OOsQ-xSn-bo'
              get :index
            end
            it 'returns status unauthorized' do
              expect(response).to have_http_status 401
            end
            it 'returns an error response' do
              body = JSON.parse(response.body).with_indifferent_access
              expect(body['errors']).to eq(not_authenticated_response)
            end
          end
        end

        context 'when a valid JWT is received' do
          let!(:user) {create(:user)}
          let(:authenticated_response) {{logged_in: 'true'}.to_json}
          before do
            @request.env["HTTP_AUTHORIZATION"] = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.__axIF2iO7Ng_Z9DZ-XnGyrjpdELL4X5OOsQ-xSn-bo'
            get :index
          end
          it 'returns status 200' do
            expect(response).to have_http_status 200
          end
          it 'returns the authenticated response' do
            expect(response.body).to eq authenticated_response
          end
          it 'responds with JSON' do
            expect(response.header['Content-Type']).to include "application/json"
          end
        end
      end
    end
  end
end
