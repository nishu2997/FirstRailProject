class Student < ApplicationRecord
    validates :rollNumber, uniqueness: true
    belongs_to :department
    has_many :courses, through: :enroll
end