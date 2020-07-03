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
end
