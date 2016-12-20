require "rails_helper"

module Api
  module V1
    RSpec.describe WelcomeController do

      describe '#index' do
        context 'without a Authorization Header JWT' do
          it 'returns status unauthorized' do
            @request.headers['Authorization'] = ''
            get :index
            expect(response).to have_http_status 401
          end
        end

        context 'with a bad JWT' do
          it 'returns status unauthorized' do
            @request.headers['Authorization'] = 'xxxx.xxxx.xxxx'
            get :index
            expect(response).to have_http_status 401
          end
        end

        context 'with a good JWT' do
          let!(:user) { User.create(email: "a@a.com", password: "password") }
          it 'returns status 200' do
            # binding.pry
            #:user=>{:id=>1, :email=>"a@a.com"}}
            @request.env["HTTP_AUTHORIZATION"] = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.__axIF2iO7Ng_Z9DZ-XnGyrjpdELL4X5OOsQ-xSn-bo'
            get :index
            expect(response).to have_http_status 200
          end
        end




      end
    end
  end

end
