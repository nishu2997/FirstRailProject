class Enroll < ApplicationRecord
    validates :course_id, presence: true
    validates :student_id, uniqueness: {case_sensitive: false, scope: :course_id}, presence: true
    belongs_to :student
    belongs_to :course
end
