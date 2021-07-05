class Course < ApplicationRecord
    validates :name, presence: true
    validates :courseCode, uniqueness: {case_sensitive: false}, presence: true
    validates :department_id, presence: true
    belongs_to :department
    has_many :students, through: :enrolls
    has_many :enrolls, dependent: :destroy
end
