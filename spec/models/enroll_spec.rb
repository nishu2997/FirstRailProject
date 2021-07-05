require 'rails_helper'

RSpec.describe Enroll, type: :model do
    
    subject{
        described_class.new(student_id: 1, course_id: 1)
    }

    before do
        Department.create!(name: "cse", departmentCode: "cse101")
        Student.create!(name: "Nishu Kumar", rollNumber: 101, department_id: 1)
        Course.create!(name: "java", courseCode: "java101", department_id: 1)
        Course.create!(name: "java advanced", courseCode: "java102", department_id: 1)
    end

    it "is not valid without valid attributes" do
        subject[:student_id], subject[:course_id] = nil
        expect(subject).not_to be_valid
    end

    it "is not valid without student id" do
        subject[:student_id] = nil
        expect(subject).not_to be_valid
    end

    it "is not valid without course id" do
        subject[:course_id] = nil
        expect(subject).not_to be_valid
    end

    it "is valid with valid attributes" do
        expect(subject).to be_valid
    end

    #spec for testing uniqueness of student id and course id combined
    describe "when combined student id and course id is not unique" do
        before do
            described_class.create!(student_id: 1, course_id: 1)
        end
        
        it "is not unique" do
            expect(subject).not_to be_valid
        end
    end

    #spec for testing uniqueness of student id and course id combined
    describe "when combined student id and course id is unique" do
        before do
            described_class.create!(student_id: 1, course_id: 2)
        end
        
        it "is unique" do
            expect(subject).to be_valid
        end
    end

    #spec for testing association with student
    describe "when enroll belongs to student" do
        
        it "should belong to student" do
            expect(described_class.reflect_on_association(:student).macro).to eq(:belongs_to)
        end
    end

    #spec for testing association with course
    describe "when enroll belongs to course" do
        
        it "should belong to course" do
            expect(described_class.reflect_on_association(:course).macro).to eq(:belongs_to)
        end
    end
end