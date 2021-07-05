require 'rails_helper'

RSpec.describe LogoutController, type: :controller do

    #spec for index method
    describe 'GET #index' do
        #test case for successful get request
        it "returns 302 status code" do
            get :index
            expect(response).to redirect_to("/")
            expect(response.content_type).to eq "text/html; charset=utf-8"
            #expect(response.body).to eq ""
            expect(response).to have_http_status(302)
        end
    end
end