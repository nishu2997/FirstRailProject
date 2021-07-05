require 'rails_helper'

RSpec.describe LoginController, type: :controller do

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

    #spec for validate method
    describe 'POST #validate' do
        #test case for successful login as admin
        it "returns 302 status code" do
            post :validate, params: {username: "admin", password: "admin"}
            expect(response).to redirect_to("/")
            expect(response.content_type).to eq "text/html; charset=utf-8"
            #expect(response.body).to eq ""
            expect(response).to have_http_status(302)
        end

        #test case for successful login as student
        it "returns 302 status code" do
            student1 = Student.new(id: 1, name: "Nishu Kumar", rollNumber: 101, department_id: 1)
            student2 = Student.new(id: 2, name: "Sourav Mondal", rollNumber: 102, department_id: 1)
            students = [student1, student2]
            expect(Student).to receive(:all).with(no_args){students}
            post :validate, params: {username: "nishu123", password: "nishu@123"}
            expect(response).to redirect_to("/")
            expect(response.content_type).to eq "text/html; charset=utf-8"
            #expect(response.body).to eq ""
            expect(response).to have_http_status(302)
        end

        #test case for unsuccessful get request(is Empty test case)
        it "returns 200 status code" do
            post :validate, params: {username: "", password: "admin"}
            expect(response).to render_template(:index)
            expect(response.content_type).to eq "text/html; charset=utf-8"
            expect(response.body).to eq ""
            expect(response).to have_http_status(:successful)
        end

        #test case for unsuccessful get request(not valid test case)
        it "returns 200 status code" do
            expect(Student).to receive(:all){[]}
            post :validate, params: {username: "admin", password: "adminn"}
            expect(response).to render_template(:index)
            expect(response.content_type).to eq "text/html; charset=utf-8"
            expect(response.body).to eq ""
            expect(response).to have_http_status(:successful)
        end
    end
end