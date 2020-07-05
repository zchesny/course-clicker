class Attendance < ApplicationRecord
    belongs_to :course 
    # has_many :user_attendances
    # has_many :users, through: :user_attendances 

    has_many :user_attendances
    has_many :user_absences 
    has_many :attendees, through: :user_attendances, source: :user 
    has_many :absentees, through: :user_absences, source: :user

    def self.find_by_course_id(course_id)
        self.all.select{|attendance| attendance.course_id == course_id}
    end 

    def self.find_by_user_id(user_id)
        self.all.select{|attendance| attendance.user_ids.include?(user_id)}
    end 

    def set_absentees(attendee_ids)
        all_student_ids = course.get_user_ids('student')
        self.absentee_ids = all_student_ids - attendee_ids
    end 

    # def absent_students
    #     all_students = course.get_user_ids('student')
    #     present_students = users
    #     absent_students = all_students - present_students 
    # end 
end
