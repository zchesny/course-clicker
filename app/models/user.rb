class User < ApplicationRecord
    has_many :user_courses 
    has_many :courses, through: :user_courses 
    # has_many :enrollments
    # has_many :courses, through: :enrollments
    # has_many :teachers, through: :courses 
    has_many :attendances 

    # courses attended? 
    has_secure_password
    validates :name, presence: true 
    validates :name, uniqueness: true 

    include Schedulable::InstanceMethods

    def student? 
        role.downcase.include?('student')
    end 

    def teacher? 
        role.downcase.include?('teacher')
    end 

    def admin? 
        role.downcase.include?('admin')
    end 
end
