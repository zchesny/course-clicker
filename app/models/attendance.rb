class Attendance < ApplicationRecord
    belongs_to :course 

    has_many :user_attendances
    has_many :user_absences 
    has_many :attendees, through: :user_attendances, source: :user 
    has_many :absentees, through: :user_absences, source: :user

    validates :date, uniqueness: {scope: :course,  message: " - Course attendance on this date has already been taken."}

    def self.find_by_course_id(course_id)
        self.all.select{|attendance| attendance.course_id == course_id}
    end 

    def self.find_by_user_id(user_id)
        self.all.select{|attendance| attendance.user_ids.include?(user_id)}
    end 

    # fixme: breaks if nil
    def set_absentees(attendee_ids)
        all_student_ids = course.get_user_ids('student')
        self.absentee_ids = all_student_ids - attendee_ids
    end 

    def attendee_list
        self.attendees.collect{|attendee| attendee.name}.join(', ')
    end 

    def absentee_list
        self.absentees.collect{|absentee| absentee.name}.join(', ')
    end 

    def self.sort_by_date(attendances)
        attendances.sort_by{|a| a.date}.reverse
    end 
end
