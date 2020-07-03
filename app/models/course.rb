class Course < ApplicationRecord
    has_many :enrollments 
    has_many :students, through: :enrollments 

    has_many :teacher_courses 
    has_many :teachers, through: :teacher_courses 

    has_many :attendances

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
        !self.schedule_days.scan(day).empty?
    end 

    def teacher_list
        self.teachers.collect{|teacher| teacher.name}.join(', ')
    end

    def self.sort_by_time(courses)
        courses.sort_by{|c| c.military_start_time}
    end
end
