require 'rails_helper'

RSpec.describe Student, type: :model do
    
    subject{
        described_class.new(name: "Nishu Kumar", rollNumber: 101, department_id: 1)
    }

    before do
        Department.create!(name: 'cse', departmentCode: 'cse101')
    end

    it "is not valid without valid attributes" do
        subject[:name], subject[:rollNumber], subject[:department_id] = nil
        expect(subject).not_to be_valid
    end

    it "is not valid without name" do
        subject[:name] = nil
        expect(subject).not_to be_valid
    end

    it "is not valid without roll number" do
        subject[:rollNumber] = nil
        expect(subject).not_to be_valid
    end

    it "is not valid without department id" do
        subject[:department_id] = nil
        expect(subject).not_to be_valid
    end

    it "is valid with valid attributes" do
        expect(subject).to be_valid
    end

    #spec for testing uniqueness of roll number
    describe "when roll number is not unique" do
        before do
            described_class.create!(name: "Shubham Kumar", rollNumber: 101, department_id: 1)
        end
        
        it "is not unique" do
            expect(subject).not_to be_valid
        end
    end

    #spec for testing uniqueness of roll number
    describe "when roll number is unique" do
        before do
            described_class.create!(name: "Shubham Kumar", rollNumber: 102, department_id: 1)
        end
        
        it "is unique" do
            expect(subject).to be_valid
        end
    end

    #spec for testing association with department
    describe "when student belongs to department" do
        
        it "should belong to department" do
            expect(described_class.reflect_on_association(:department).macro).to eq(:belongs_to)
        end
    end

    #spec for testing association with enroll
    describe "when student has many enrolls" do
        
        it "should have many enroll" do
            expect(described_class.reflect_on_association(:enrolls).macro).to eq(:has_many)
        end
    end

    #spec for testing association of with course
    describe "when student has many courses" do
        
        it "should have many courses" do
            expect(described_class.reflect_on_association(:courses).macro).to eq(:has_many)
        end
    end
end