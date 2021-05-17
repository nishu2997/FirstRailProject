class Course < ApplicationRecord
    validates :courseCode, uniqueness: {case_sensitive: false}
    belongs_to :department
    has_many :students, through: :enroll
end
