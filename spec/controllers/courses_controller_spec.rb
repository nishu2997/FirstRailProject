require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  
    #specs for index method
    describe 'GET #index' do
       #test case for successful get request
       it "returns 200 status code" do
            courses = double('courses')
            expect(Course).to receive(:all){courses}
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
            departments = double('departments')
            course = double('course')
            expect(Course).to receive(:new).with(no_args){course}
            expect(Department).to receive(:all).with(no_args){departments}
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
            student = double('student')
            course = double('course')
            expect(Course).to receive(:find) do |arg|
                expect(arg).to be_an_instance_of(String).or be_an_instance_of(Fixnum)
                course
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
            course = Course.new(id: 1, name: "java", courseCode: "java101", department_id: 1)
            departments = double('departments')
            expect(Department).to receive(:all).with(no_args){departments}
            expect(Course).to receive(:new) do |args|
                expect(args).to be_an_instance_of(ActionController::Parameters)
                args = args.to_hash
                expect(args.length).to eq 3
                expect(args.has_key?('name')).to be_truthy
                expect(args.has_key?('courseCode')).to be_truthy
                expect(args.has_key?('department_id')).to be_truthy
                course
            end
            expect(course).to receive(:save).with(no_args){true}
            post :create, params: {course: {name: 'java', courseCode: 'java101', department_id: 1}}
            expect(response).to redirect_to("/courses")
            expect(response.content_type).to eq "text/html; charset=utf-8"
            #expect(response.body).to eq ""
            expect(response).to have_http_status(302)
        end

        #test case for successful post request 2
        it "returns 302 status code" do
            course = Course.new(id: 1, name: "java", courseCode: "java101", department_id: 1)
            departments = double('departments')
            expect(Department).to receive(:all).with(no_args){departments}
            expect(Course).to receive(:new) do |args|
                expect(args).to be_an_instance_of(ActionController::Parameters)
                args = args.to_hash
                expect(args.length).to eq 3
                expect(args.has_key?('name')).to be_truthy
                expect(args.has_key?('courseCode')).to be_truthy
                expect(args.has_key?('department_id')).to be_truthy
                course
            end
            expect(course).to receive(:save).with(no_args){true}
            post :create, params: {course: {name: 'java', courseCode: 'java101', department_id: 1, rollNumber: 101}}
            expect(response).to redirect_to("/courses")
            expect(response.content_type).to eq "text/html; charset=utf-8"
            #expect(response.body).to eq ""
            expect(response).to have_http_status(302)
        end

        #test case for unsuccessful post request
        it "returns 200 status code" do
            departments = double("departments")
            course = double('course')
            expect(Course).to receive(:new) do |args|
                expect(args).to be_an_instance_of(ActionController::Parameters)
                args = args.to_hash
                expect(args.length).to eq 3
                expect(args.has_key?('name')).to be_truthy
                expect(args.has_key?('courseCode')).to be_truthy
                expect(args.has_key?('department_id')).to be_truthy
                course
            end
            expect(course).to receive(:save).with(no_args){false}
            expect(Department).to receive(:all).with(no_args){departments}
            post :create, params: {course: {name: '', courseCode: 'java101', department_id: 1}}
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
            departments = double('departments')
            course = double('course')
            expect(Course).to receive(:find) do |arg|
                expect(arg).to be_an_instance_of(String).or be_an_instance_of(Fixnum)
                course
            end
            expect(Department).to receive(:all).with(no_args){departments}
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
            course = Course.new(id: 1, name: "java", courseCode: "java101", department_id: 1)
            expect(Course).to receive(:find) do |arg|
                expect(arg).to be_an_instance_of(String).or be_an_instance_of(Fixnum)
                course
            end
            expect(course).to receive(:update) do |args|
                expect(args).to be_an_instance_of(ActionController::Parameters)
                args = args.to_hash
                expect(args.length).to eq 3
                expect(args.has_key?('name')).to be_truthy
                expect(args.has_key?('courseCode')).to be_truthy
                expect(args.has_key?('department_id')).to be_truthy
                true
            end
            put :update, params: {id: 1, course: {name: 'java', courseCode: 'java101', department_id: 1}}
            expect(response).to redirect_to("/courses")
            expect(response.content_type).to eq "text/html; charset=utf-8"
            #expect(response.body).to eq ""
            expect(response).to have_http_status(302)
        end

        #test case for successful post request 2
        it "returns 302 status code" do
            course = Course.new(id: 1, name: "java", courseCode: "java101", department_id: 1)
            expect(Course).to receive(:find) do |arg|
                expect(arg).to be_an_instance_of(String).or be_an_instance_of(Fixnum)
                course
            end
            expect(course).to receive(:update) do |args|
                expect(args).to be_an_instance_of(ActionController::Parameters)
                args = args.to_hash
                expect(args.length).to eq 3
                expect(args.has_key?('name')).to be_truthy
                expect(args.has_key?('courseCode')).to be_truthy
                expect(args.has_key?('department_id')).to be_truthy
                true
            end
            put :update, params: {id: 1, course: {name: 'java', courseCode: 'java101', department_id: 1, rollNumber: 101}}
            expect(response).to redirect_to("/courses")
            expect(response.content_type).to eq "text/html; charset=utf-8"
            #expect(response.body).to eq ""
            expect(response).to have_http_status(302)
        end

        #test case for unsuccessful post request
        it "returns 200 status code" do
            course = double('course')
            expect(Course).to receive(:find) do |arg|
                expect(arg).to be_an_instance_of(String).or be_an_instance_of(Fixnum)
                course
            end
            expect(course).to receive(:update) do |args|
                expect(args).to be_an_instance_of(ActionController::Parameters)
                args = args.to_hash
                expect(args.length).to eq 3
                expect(args.has_key?('name')).to be_truthy
                expect(args.has_key?('courseCode')).to be_truthy
                expect(args.has_key?('department_id')).to be_truthy
                false
            end
            put :update, params: {id: 1, course: {name: '', courseCode: 'java101', department_id: 1}}
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
            course = double('course')
            expect(Course).to receive(:find) do |arg|
                expect(arg).to be_an_instance_of(String).or be_an_instance_of(Fixnum)
                course
            end
            expect(course).to receive(:destroy).with(no_args){true}
            delete :destroy, params: {id: 1}
            expect(response).to redirect_to("/courses")
            expect(response.content_type).to eq "text/html; charset=utf-8"
            #expect(response.body).to eq ""
            expect(response).to have_http_status(302)
        end
    end
end