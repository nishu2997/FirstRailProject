require 'rails_helper'

RSpec.describe EnrollsController, type: :controller do

    #spec for index method
    describe 'GET #index' do
        #test case for successful get request
        it "returns 200 status code" do
            student = double('student')
            courses = double('courses')
            expect(Student).to receive(:find) do |arg|
                expect(arg).to be_an_instance_of(String).or be_an_instance_of(Fixnum)
                student
            end
            expect(Course).to receive(:joins) do |args|
                expect(args).to be_an_instance_of(Hash)
                expect(args.length).to eq 1
                expect(args.has_key?(:enrolls)).to be_truthy
                courses
            end
            expect(courses).to receive(:where) do |args|
                expect(args).to be_an_instance_of(Hash)
                expect(args.length).to eq 1
                expect(args.has_key?(:student)).to be_truthy
                courses
            end
            get :index, params: {student_id: 1}
            expect(response.content_type).to eq "text/html; charset=utf-8"
            expect(response.body).to eq ""
            expect(response).to have_http_status(:successful)
        end
    end

    #spec for create method
    describe 'POST #create' do
        #test case for successful post request 1
        it "returns 302 status code" do
            student = double('student')
            enroll = double('enroll')
            expect(Student).to receive(:find) do |arg|
                expect(arg).to be_an_instance_of(String).or be_an_instance_of(Fixnum)
                student
            end
            expect(Enroll).to receive(:new) do |args|
                expect(args).to be_an_instance_of(ActionController::Parameters)
                args = args.to_hash
                expect(args.length).to eq 2
                expect(args.has_key?('student_id')).to be_truthy
                expect(args.has_key?('course_id')).to be_truthy
                enroll
            end
            expect(student).to receive_message_chain(:enrolls, :build) do |args|
                expect(args).to be_an_instance_of(ActionController::Parameters)
                args = args.to_hash
                expect(args.length).to eq 2
                expect(args.has_key?('student_id')).to be_truthy
                expect(args.has_key?('course_id')).to be_truthy
                enroll
            end
            expect(enroll).to receive(:save).with(no_args){true}
            post :create, params: {student_id: 1, enroll: {student_id: 1, course_id: 1}}
            expect(response).to redirect_to("/courses")
            expect(response.content_type).to eq "text/html; charset=utf-8"
            #expect(response.body).to eq ""
            expect(response).to have_http_status(302)
        end

        #test case for successful post request 2
        it "returns 302 status code" do
            student = double('student')
            enroll = double('enroll')
            expect(Student).to receive(:find) do |arg|
                expect(arg).to be_an_instance_of(String).or be_an_instance_of(Fixnum)
                student
            end
            expect(Enroll).to receive(:new) do |args|
                expect(args).to be_an_instance_of(ActionController::Parameters)
                args = args.to_hash
                expect(args.length).to eq 2
                expect(args.has_key?('student_id')).to be_truthy
                expect(args.has_key?('course_id')).to be_truthy
                enroll
            end
            expect(student).to receive_message_chain(:enrolls, :build) do |args|
                expect(args).to be_an_instance_of(ActionController::Parameters)
                args = args.to_hash
                expect(args.length).to eq 2
                expect(args.has_key?('student_id')).to be_truthy
                expect(args.has_key?('course_id')).to be_truthy
                enroll
            end
            expect(enroll).to receive(:save).with(no_args){true}
            post :create, params: {student_id: 1, enroll: {student_id: 1, course_id: 1, department_id: 1}}
            expect(response).to redirect_to("/courses")
            expect(response.content_type).to eq "text/html; charset=utf-8"
            #expect(response.body).to eq ""
            expect(response).to have_http_status(302)
        end

        #test case for unsuccessful post request
        it "returns 200 status code" do
            student = double('student')
            enroll = double('enroll')
            course = Course.new(id: 1, name: 'java', courseCode: 'java101', department_id: 1)
            expect(Student).to receive(:find) do |arg|
                expect(arg).to be_an_instance_of(String).or be_an_instance_of(Fixnum)
                student
            end
            expect(Enroll).to receive(:new) do |args|
                expect(args).to be_an_instance_of(ActionController::Parameters)
                args = args.to_hash
                expect(args.length).to eq 2
                expect(args.has_key?('student_id')).to be_truthy
                expect(args.has_key?('course_id')).to be_truthy
                enroll
            end
            expect(student).to receive_message_chain(:enrolls, :build) do |args|
                expect(args).to be_an_instance_of(ActionController::Parameters)
                args = args.to_hash
                expect(args.length).to eq 2
                expect(args.has_key?('student_id')).to be_truthy
                expect(args.has_key?('course_id')).to be_truthy
                enroll
            end
            expect(enroll).to receive(:save).with(no_args){false}
            expect(enroll).to receive(:course_id).with(no_args){1}
            expect(Course).to receive(:find).with(1){course}
            post :create, params: {student_id: 1, enroll: {student_id: 0, course_id: 1}}
            expect(response).to render_template("courses/show")
            expect(response.content_type).to eq "text/html; charset=utf-8"
            expect(response.body).to eq ""
            expect(response).to have_http_status(:successful)
        end
    end

    #spec for destroy method
    describe "DELETE #destroy" do

        #test case for successful delete request
        it "returns 302 status code" do
            enroll = double('enroll')
            expect(Enroll).to receive(:find) do |arg|
                expect(arg).to be_an_instance_of(String).or be_an_instance_of(Fixnum)
                enroll
            end
            expect(enroll).to receive(:destroy).with(no_args){true}
            delete :destroy, params: {id: 1, student_id: 1}
            expect(response).to redirect_to("/students/1/enrolls")
            expect(response.content_type).to eq "text/html; charset=utf-8"
            #expect(response.body).to eq ""
            expect(response).to have_http_status(302)
        end
    end
end