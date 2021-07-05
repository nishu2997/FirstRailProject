require 'rails_helper'

RSpec.describe StudentsController, type: :controller do

    #specs for index method
    describe 'GET #index' do
       #test case for successful get request
       it "returns 200 status code" do
            students = double('students')
            expect(Student).to receive(:all){students}
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
            student = double('student')
            expect(Student).to receive(:new).with(no_args){student}
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
            department = double('department')
            courses = double('courses')
            enroll1 = Enroll.new(student_id: 1, course_id: 1);
            enroll2 = Enroll.new(student_id: 1, course_id: 2);
            enrolls = [enroll1, enroll2]
            expect(Student).to receive(:find) do |arg|
                expect(arg).to be_an_instance_of(String).or be_an_instance_of(Fixnum)
                student
            end
            expect(student).to receive(:department_id).with(no_args){1}
            expect(student).to receive(:id).with(no_args){1}
            expect(Department).to receive(:find) do |arg|
                expect(arg).to be_an_instance_of(String).or be_an_instance_of(Fixnum)
                department
            end
            expect(Enroll).to receive(:where) do |args|
                expect(args).to be_an_instance_of(Hash)
                expect(args.length).to eq 1
                expect(args.has_key?(:student_id)).to be_truthy
                enrolls
            end
            expect(Course).to receive(:find).with([1, 2]){courses}
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
            student = Student.new(id: 1, name: 'Nishu Kumar', rollNumber: 101, department_id: 1)
            departments = double('departments')
            expect(Department).to receive(:all).with(no_args){departments}
            expect(Student).to receive(:new) do |args|
                expect(args).to be_an_instance_of(ActionController::Parameters)
                args = args.to_hash
                expect(args.length).to eq 3
                expect(args.has_key?('name')).to be_truthy
                expect(args.has_key?('rollNumber')).to be_truthy
                expect(args.has_key?('department_id')).to be_truthy
                student
            end
            expect(student).to receive(:save).with(no_args){true}
            post :create, params: {student: {name: 'Nishu Kumar', rollNumber: 101, department_id: 1}}
            expect(response).to redirect_to("/students")
            expect(response.content_type).to eq "text/html; charset=utf-8"
            #expect(response.body).to eq ""
            expect(response).to have_http_status(302)
        end

        #test case for successful post request 2
        it "returns 302 status code" do
            student = Student.new(id: 1, name: 'Nishu Kumar', rollNumber: 101, department_id: 1)
            departments = double('departments')
            expect(Department).to receive(:all).with(no_args){departments}
            expect(Student).to receive(:new) do |args|
                expect(args).to be_an_instance_of(ActionController::Parameters)
                args = args.to_hash
                expect(args.length).to eq 3
                expect(args.has_key?('name')).to be_truthy
                expect(args.has_key?('rollNumber')).to be_truthy
                expect(args.has_key?('department_id')).to be_truthy
                student
            end
            expect(student).to receive(:save).with(no_args){true}
            post :create, params: {student: {name: 'Nishu Kumar', rollNumber: 101, department_id: 1, courseCode: "java101"}}
            expect(response).to redirect_to("/students")
            expect(response.content_type).to eq "text/html; charset=utf-8"
            #expect(response.body).to eq ""
            expect(response).to have_http_status(302)
        end

        #test case for unsuccessful post request
        it "returns 200 status code" do
            departments = double("departments")
            student = double('student')
            expect(Student).to receive(:new) do |args|
                expect(args).to be_an_instance_of(ActionController::Parameters)
                args = args.to_hash
                expect(args.length).to eq 3
                expect(args.has_key?('name')).to be_truthy
                expect(args.has_key?('rollNumber')).to be_truthy
                expect(args.has_key?('department_id')).to be_truthy
                student
            end
            expect(student).to receive(:save).with(no_args){false}
            expect(Department).to receive(:all).with(no_args){departments}
            post :create, params: {student: {name: '', rollNumber: 101, department_id: 1}}
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
            student = Student.new(id: 1, name: "Nishu Kumar", rollNumber: 101, department_id: 1)
            enroll1 = Enroll.new(student_id: 1, course_id: 1);
            enroll2 = Enroll.new(student_id: 1, course_id: 2);
            enrolls = [enroll1, enroll2]
            course1 = Course.new(id: 1, name: 'java', courseCode: 'java101', department_id: 1)
            course2 = Course.new(id: 2, name: 'python', courseCode: 'python101', department_id: 1)
            course3 = Course.new(id: 3, name: 'ruby', courseCode: 'ruby101', department_id: 1)
            allCourses = [course1, course2, course3]
            enrolledCourses = [course1, course2]
            expect(Student).to receive(:find) do |arg|
                expect(arg).to be_an_instance_of(String).or be_an_instance_of(Fixnum)
                student
            end            
            expect(Department).to receive(:all).with(no_args){departments}
            expect(Enroll).to receive(:where) do |args|
                expect(args).to be_an_instance_of(Hash)
                expect(args.length).to eq 1
                expect(args.has_key?(:student_id)).to be_truthy
                enrolls
            end
            expect(Course).to receive(:find).with([1, 2]){enrolledCourses}
            expect(Course).to receive(:all){allCourses}
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
            student = Student.new(id: 1, name: 'Nishu Kumar', rollNumber: 101, department_id: 1)
            expect(Student).to receive(:find) do |arg|
                expect(arg).to be_an_instance_of(String).or be_an_instance_of(Fixnum)
                student
            end
            expect(student).to receive(:update) do |args|
                expect(args).to be_an_instance_of(ActionController::Parameters)
                args = args.to_hash
                expect(args.length).to eq 3
                expect(args.has_key?('name')).to be_truthy
                expect(args.has_key?('rollNumber')).to be_truthy
                expect(args.has_key?('department_id')).to be_truthy
                true
            end
            put :update, params: {id: 1, student: {name: 'Nishu Kumar', rollNumber: 101, department_id: 1}}
            expect(response).to redirect_to("/students")
            expect(response.content_type).to eq "text/html; charset=utf-8"
            #expect(response.body).to eq ""
            expect(response).to have_http_status(302)
        end

        #test case for successful post request 2
        it "returns 302 status code" do
            student = Student.new(id: 1, name: 'Nishu Kumar', rollNumber: 101, department_id: 1)
            expect(Student).to receive(:find) do |arg|
                expect(arg).to be_an_instance_of(String).or be_an_instance_of(Fixnum)
                student
            end
            expect(student).to receive(:update) do |args|
                expect(args).to be_an_instance_of(ActionController::Parameters)
                args = args.to_hash
                expect(args.length).to eq 3
                expect(args.has_key?('name')).to be_truthy
                expect(args.has_key?('rollNumber')).to be_truthy
                expect(args.has_key?('department_id')).to be_truthy
                true
            end
            put :update, params: {id: 1, student: {name: 'Nishu Kumar', rollNumber: 101, department_id: 1, courseCode: "java101"}}
            expect(response).to redirect_to("/students")
            expect(response.content_type).to eq "text/html; charset=utf-8"
            #expect(response.body).to eq ""
            expect(response).to have_http_status(302)
        end

        #test case for unsuccessful post request
        it "returns 200 status code" do
            student = double('student')
            expect(Student).to receive(:find) do |arg|
                expect(arg).to be_an_instance_of(String).or be_an_instance_of(Fixnum)
                student
            end
            expect(student).to receive(:update) do |args|
                expect(args).to be_an_instance_of(ActionController::Parameters)
                args = args.to_hash
                expect(args.length).to eq 3
                expect(args.has_key?('name')).to be_truthy
                expect(args.has_key?('rollNumber')).to be_truthy
                expect(args.has_key?('department_id')).to be_truthy
                false
            end
            put :update, params: {id: 1, student: {name: '', rollNumber: 1, department_id: 1}}
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
            student = double('student')
            expect(Student).to receive(:find) do |arg|
                expect(arg).to be_an_instance_of(String) or be_an_instance_of(Fixnum)
                student
            end
            expect(student).to receive(:destroy).with(no_args){true}
            delete :destroy, params: {id: 1}
            expect(response).to redirect_to("/students")
            expect(response.content_type).to eq "text/html; charset=utf-8"
            #expect(response.body).to eq ""
            expect(response).to have_http_status(302)
        end
    end
end