class Enroll < ApplicationRecord
    validates :student_id, uniqueness: {case_sensitive: false, scope: :course_id}
    belongs_to :student
    belongs_to :course
end
