class User < ApplicationRecord
    has_many :user_courses 
    has_many :courses, through: :user_courses 
    has_many :attendance_entries 

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
        self.all.select{|user| user.role?(role)}.sort_by{|u| u.name.downcase}
    end 

    def self.sort_by_name
        self.all.sort_by{|u| u.name.downcase}
    end 
    
    def get_schedule_hash()
        overlap = false  
        shash = {} 
        Course.sort_by_time(self.courses).each do |course| 
            ["Mon", "Tue", "Wed", "Thu", "Fri"].each do |day| 
                if course.scheduled_on?(day) 
                    if shash[course.time] and shash[course.time][day]
                        dlist = shash[course.time][day]
                        dlist << course 
                        overlap = true 
                    elsif shash[course.time]
                        thash = shash[course.time] 
                        thash[day] = [course]
                    else
                        shash[course.time] = {day => [course]}
                    end 
                end 
            end 
        end 
        [overlap, shash] 
    end 

end
