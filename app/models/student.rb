class Student < ApplicationRecord
    validates :name, presence: true
    validates :rollNumber, uniqueness: true, presence: true
    validates :department_id, presence: true
    belongs_to :department
    has_many :courses, through: :enrolls
    has_many :enrolls, dependent: :destroy
end
