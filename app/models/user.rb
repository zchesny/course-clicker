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

    def role?(role)
        self.role.downcase.include?(role)
    end 

    def self.all_users(role)
        self.all.select{|user| user.role?(role)}
    end 

end
