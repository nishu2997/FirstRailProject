require 'rails_helper'

RSpec.describe Department, type: :model do
    
    subject{
        described_class.new(name: "cse", departmentCode: "cse101")
    }

    it "is not valid without name and department attributes" do
        subject[:name], subject[:departmentCode] = nil
        expect(subject).not_to be_valid
    end

    it "is not valid without name" do
        subject[:name] = nil
        expect(subject).not_to be_valid
    end

    it "is not valid without department code" do
        subject[:departmentCode] = nil
        expect(subject).not_to be_valid
    end

    it "is valid with valid attributes" do
        expect(subject).to be_valid
    end

    #spec for testing uniqueness of department code
    describe "when department code is not unique" do
        before do
            described_class.create!(name: "it", departmentCode: "cse101")
        end
        
        it "is not unique" do
            expect(subject).not_to be_valid
        end
    end

    #spec for testing uniqueness of department code
    describe "when department code is unique" do
        before do
            described_class.create!(name: "it", departmentCode: "it101")
        end
        
        it "is unique" do
            expect(subject).to be_valid
        end
    end

    #spec for testing association of department with student
    describe "when department has many students" do
        
        it "should have many students" do
            expect(described_class.reflect_on_association(:students).macro).to eq(:has_many)
        end
    end

    #spec for testing association of department with course
    describe "when department has many courses" do
        
        it "should have many courses" do
            expect(described_class.reflect_on_association(:courses).macro).to eq(:has_many)
        end
    end
end