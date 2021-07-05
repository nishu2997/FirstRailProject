require 'rails_helper'

RSpec.describe DepartmentsController, type: :controller do

    #specs for index method
    describe 'GET #index' do
       #test case for successful get request
       it "returns 200 status code" do
            departments = double('departments')
            expect(Department).to receive(:all){departments}
            get :index
            expect(response.content_type).to eq "text/html; charset=utf-8"
            expect(response.body).to eq ""
            expect(response).to have_http_status(:successful)
       end
    end

    #spec for new method
    describe 'GET #new' do
        #test case for successful get request
        it "returns 200 status code" do
            department = double('department')
            expect(Department).to receive(:new).with(no_args){department}
            get :new
            expect(response.content_type).to eq "text/html; charset=utf-8"
            expect(response.body).to eq ""
            expect(response).to have_http_status(:successful)
        end
    end

    #spec for show method
    describe 'GET #show' do
        #test case for successful get request
        it "returns 200 status code" do
            department = double('department')
            expect(Department).to receive(:find) do |arg|
                expect(arg).to be_an_instance_of(String).or be_an_instance_of(Fixnum)
                department
            end
            get :show, params: {id: 1}
            expect(response.content_type).to eq "text/html; charset=utf-8"
            expect(response.body).to eq ""
            expect(response).to have_http_status(:successful)
        end
    end

    #spec for create method
    describe 'POST #create' do
        #test case for successful post request 1
        it "returns 302 status code" do
            department = Department.new(id: 1, name: "cse", departmentCode: "cs101")
            expect(Department).to receive(:new) do |args|
                expect(args).to be_an_instance_of(ActionController::Parameters)
                args = args.to_hash
                expect(args.length).to eq 2
                expect(args.has_key?('name')).to be_truthy
                expect(args.has_key?('departmentCode')).to be_truthy
                department
            end
            expect(department).to receive(:save).with(no_args){true}
            post :create, params: {department: {name: "cse", departmentCode: "cs101"}}
            expect(response).to redirect_to("/departments")
            expect(response.content_type).to eq "text/html; charset=utf-8"
            #expect(response.body).to eq ""
            expect(response).to have_http_status(302)
        end

        #test case for successful post request 2
        it "returns 302 status code" do
            department = Department.new(id: 1, name: "cse", departmentCode: "cs101")
            expect(Department).to receive(:new) do |args|
                expect(args).to be_an_instance_of(ActionController::Parameters)
                args = args.to_hash
                expect(args.length).to eq 2
                expect(args.has_key?('name')).to be_truthy
                expect(args.has_key?('departmentCode')).to be_truthy
                department
            end
            expect(department).to receive(:save).with(no_args){true}
            post :create, params: {department: {name: "cse", departmentCode: "cs101", rollNumber: 101}}
            expect(response).to redirect_to("/departments")
            expect(response.content_type).to eq "text/html; charset=utf-8"
            #expect(response.body).to eq ""
            expect(response).to have_http_status(302)
        end

        #test case for unsuccessful post request
        it "returns 200 status code" do
            department = double("department")
            expect(Department).to receive(:new) do |args|
                expect(args).to be_an_instance_of(ActionController::Parameters)
                args = args.to_hash
                expect(args.length).to eq 2
                expect(args.has_key?('name')).to be_truthy
                expect(args.has_key?('departmentCode')).to be_truthy
                department
            end
            expect(department).to receive(:save).with(no_args){false}
            post :create, params: {department: {name: "", departmentCode: ""}}
            expect(response).to render_template(:new)
            expect(response.content_type).to eq "text/html; charset=utf-8"
            expect(response.body).to eq ""
            expect(response).to have_http_status(:successful)
        end
    end

    #spec for edit method
    describe 'GET #edit' do
        #test case for successful get request
        it "returns 200 status code" do
            department = double('department')
            expect(Department).to receive(:find) do |arg|
                expect(arg).to be_an_instance_of(String).or be_an_instance_of(Fixnum)
                department
            end
            get :edit, params: {id: 1}
            expect(response.content_type).to eq "text/html; charset=utf-8"
            expect(response.body).to eq ""
            expect(response).to have_http_status(:successful)
        end
    end

    #spec for update method
    describe 'PUT #update' do
        #test case for successful post request 1
        it "returns 302 status code" do
            department = Department.new(id: 1, name: "cse", departmentCode: "cs101")
            expect(Department).to receive(:find) do |arg|
                expect(arg).to be_an_instance_of(String).or be_an_instance_of(Fixnum)
                department
            end
            expect(department).to receive(:update) do |args|
                expect(args).to be_an_instance_of(ActionController::Parameters)
                args = args.to_hash
                expect(args.length).to eq 2
                expect(args.has_key?('name')).to be_truthy
                expect(args.has_key?('departmentCode')).to be_truthy
                true
            end
            put :update, params: {id: 1, department: {name: "cse", departmentCode: "cs101"}}
            expect(response).to redirect_to("/departments")
            expect(response.content_type).to eq "text/html; charset=utf-8"
            #expect(response.body).to eq ""
            expect(response).to have_http_status(302)
        end

          #test case for successful post request 2
        it "returns 302 status code" do
            department = Department.new(id: 1, name: "cse", departmentCode: "cs101")
            expect(Department).to receive(:find) do |arg|
                expect(arg).to be_an_instance_of(String).or be_an_instance_of(Fixnum)
                department
            end
            expect(department).to receive(:update) do |args|
                expect(args).to be_an_instance_of(ActionController::Parameters)
                args = args.to_hash
                expect(args.length).to eq 2
                expect(args.has_key?('name')).to be_truthy
                expect(args.has_key?('departmentCode')).to be_truthy
                true
            end
            put :update, params: {id: 1, department: {name: "cse", departmentCode: "cs101", rollNumber: 101}}
            expect(response).to redirect_to("/departments")
            expect(response.content_type).to eq "text/html; charset=utf-8"
            #expect(response.body).to eq ""
            expect(response).to have_http_status(302)
        end

        #test case for unsuccessful post request
        it "returns 200 status code" do
            department = double("department")
            expect(Department).to receive(:find) do |arg|
                expect(arg).to be_an_instance_of(String).or be_an_instance_of(Fixnum)
                department
            end
            expect(department).to receive(:update) do |args|
                expect(args).to be_an_instance_of(ActionController::Parameters)
                args = args.to_hash
                expect(args.length).to eq 2
                expect(args.has_key?('name')).to be_truthy
                expect(args.has_key?('departmentCode')).to be_truthy
                false
            end
            put :update, params: {id: 1, department: {name: "", departmentCode: "cs101"}}
            expect(response).to render_template(:edit)
            expect(response.content_type).to eq "text/html; charset=utf-8"
            expect(response.body).to eq ""
            expect(response).to have_http_status(:successful)
        end
    end

    #spec for destroy method
    describe 'DELETE #destroy' do
        #test case for successful delete request
        it "returns 302 status code" do
            department = double('department')
            expect(Department).to receive(:find) do |arg|
                expect(arg).to be_an_instance_of(String).or be_an_instance_of(Fixnum)
                department
            end
            expect(department).to receive(:destroy).with(no_args){true}
            delete :destroy, params: {id: 1}
            expect(response).to redirect_to("/departments")
            expect(response.content_type).to eq "text/html; charset=utf-8"
            #expect(response.body).to eq ""
            expect(response).to have_http_status(302)
        end
    end
end