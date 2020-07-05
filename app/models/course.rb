class Course < ApplicationRecord
    has_many :user_courses
    has_many :users, through: :user_courses 

    # has_many :enrollments 
    # has_many :students, through: :enrollments 

    # has_many :teacher_courses 
    # has_many :teachers, through: :teacher_courses 

    has_many :attendances

    def get_users(role) 
        users.select{|user| user.role?(role)}
    end 

    def get_user_ids(role) 
        users.select{|user| user.role?(role)}.map{|user| user.id}
    end 

    def get_users_count(role)
        get_users(role).count
    end 

    def weekly_schedule_attribute=(weekly_schedule_attribute)
        self.weekly_schedule = weekly_schedule_attribute.join('/')
        self.save
    end 

    def start_time 
        military_start_time.strftime("%I:%M %p")
    end 

    def end_time 
        (military_start_time + duration * 60).strftime("%I:%M %p")
    end

    def time 
        "#{self.start_time} - #{self.end_time}"
    end 

    def scheduled_on?(day)
        !self.weekly_schedule.scan(day).empty?
    end 

    def role_list(role)
        self.get_users(role).collect{|user| user.name}.join(', ')
    end

    def self.sort_by_time(courses)
        courses.sort_by{|c| c.military_start_time}
    end
end
