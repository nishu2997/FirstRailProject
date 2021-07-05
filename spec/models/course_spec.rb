require 'rails_helper'

RSpec.describe Course, type: :model do
    
    subject{
        described_class.new(name: "java", courseCode: "java101", department_id: 1)
    }

    before do
        Department.create!(name: 'cse', departmentCode: 'cse101')
    end

    it "is not valid without valid attributes" do
        subject[:name], subject[:courseCode], subject[:department_id] = nil
        expect(subject).not_to be_valid
    end

    it "is not valid without name" do
        subject[:name] = nil
        expect(subject).not_to be_valid
    end

    it "is not valid without course code" do
        subject[:courseCode] = nil
        expect(subject).not_to be_valid
    end

    it "is not valid without department id" do
        subject[:department_id] = nil
        expect(subject).not_to be_valid
    end

    it "is valid with valid attributes" do
        expect(subject).to be_valid
    end

    #spec for testing uniqueness of course code
    describe "when course code is not unique" do
        before do
            described_class.create!(name: "java advanced", courseCode: "java101", department_id: 1)
        end
        
        it "is not unique" do
            expect(subject).not_to be_valid
        end
    end

    #spec for testing uniqueness of course code
    describe "when course code is unique" do
        before do
            described_class.create!(name: "java advanced", courseCode: "java102", department_id: 1)
        end
        
        it "is unique" do
            expect(subject).to be_valid
        end
    end

    #spec for testing association with department
    describe "when course belongs to department" do
        
        it "should belong to department" do
            expect(described_class.reflect_on_association(:department).macro).to eq(:belongs_to)
        end
    end

    #spec for testing association with student
    describe "when course has many students" do
        
        it "should have many students" do
            expect(described_class.reflect_on_association(:students).macro).to eq(:has_many)
        end
    end

    #spec for testing association of with enroll
    describe "when course has many enrolls" do
        
        it "should have many enrolls" do
            expect(described_class.reflect_on_association(:enrolls).macro).to eq(:has_many)
        end
    end
end