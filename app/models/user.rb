class User < ApplicationRecord
    has_many :user_courses 
    has_many :courses, through: :user_courses 
    # has_many :enrollments
    # has_many :courses, through: :enrollments
    # has_many :teachers, through: :courses 
    has_many :user_attendances
    has_many :attendances, through: :user_attendances 

    # courses attended? 
    has_secure_password
    validates :name, presence: true 
    validates :name, uniqueness: true 

    include Schedulable::InstanceMethods

    def role?(role)
        self.role.downcase.include?(role)
    end 

    def course_list 
        self.courses.collect{|course| course.name}.join(', ')
    end 

    def self.all_users(role)
        self.all.select{|user| user.role?(role)}
    end 

    def self.sort_by_name
        self.all.sort_by{|u| u.name}
    end 

end
