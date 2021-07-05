class Department < ApplicationRecord
    validates :name, presence: true
    validates :departmentCode, uniqueness: {case_sensitive: false}, presence: true
    has_many :students, dependent: :destroy
    has_many :courses, dependent: :destroy
end
