class Student < ApplicationRecord
    has_many :enrollments
    has_many :courses, through: :enrollments
    has_many :teachers, through: :courses 
    has_many :attendances 

    # courses attended? 
    has_secure_password
end
