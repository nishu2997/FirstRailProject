require 'rails_helper'

RSpec.describe HomeController, type: :controller do

    #spec for index method
    describe 'GET #index' do
        #test case for successful get request
        it "returns 200 status code" do
            get :index
            expect(response.content_type).to eq "text/html; charset=utf-8"
            expect(response.body).to eq ""
            expect(response).to have_http_status(:successful)
        end
    end
end