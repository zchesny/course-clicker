class User < ApplicationRecord
    has_many :user_courses 
    has_many :courses, through: :user_courses 

    has_many :user_attendances
    has_many :attendances, through: :user_attendances 

    has_secure_password
    validates :name, presence: true 
    validates :name, uniqueness: true 

    # need validation code 
    attr_accessor :code
    # validates :name, uniqueness: {scope: :role,  message: " - A user with this name and role has already been created."} 

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

    def self.most_courses 
        self.all.max_by do |u|
            u.courses.size
        end 
    end 

end
