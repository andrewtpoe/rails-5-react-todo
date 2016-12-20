require "rails_helper"

module Api
  module V1
    RSpec.describe WelcomeController do

      describe '#index' do

        context 'when no Authorization Header is received' do
          let(:not_authenticated_response) {["Not Authenticated No User ID In Token"]}
          it 'returns status unauthorized' do
            @request.headers['Authorization'] = ''
            get :index
            expect(response).to have_http_status 401
            body = JSON.parse(response.body).with_indifferent_access
            expect(body['errors']).to eq(not_authenticated_response)
          end
        end

        context 'when a bad JWT is received' do
          let(:not_authenticated_response) {["Not Authenticated No User ID In Token"]}
          it 'returns status unauthorized' do
            @request.headers['Authorization'] = 'earer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.__axIF2iO7Ng_Z9DZ-XnGyrjpdELL4X5OOsQ-xSn-ho'
            get :index
            body = JSON.parse(response.body).with_indifferent_access
            expect(body['errors']).to eq(not_authenticated_response)
            expect(response).to have_http_status 401
          end
        end

        context 'when a good JWT is received' do
          let!(:user) { User.create(email: "a@a.com", password: "password") }
          let(:authenticated_response) {{logged_in: 'true'}.to_json}
          it 'returns status 200' do
            # binding.pry
            #:user=>{:id=>1, :email=>"a@a.com"}}
            @request.env["HTTP_AUTHORIZATION"] = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.__axIF2iO7Ng_Z9DZ-XnGyrjpdELL4X5OOsQ-xSn-bo'
            get :index
            expect(response.body).to eq authenticated_response
            expect(response).to have_http_status 200
          end
        end
      end
    end
  end
end
