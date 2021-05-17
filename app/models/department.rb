class Department < ApplicationRecord
    validates :departmentCode, uniqueness: {case_sensitive: false}
    has_many :students
    has_many :courses
end
