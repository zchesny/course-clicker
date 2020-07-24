class Attendance < ApplicationRecord
    belongs_to :course 

    has_many :user_attendances
    has_many :user_absences 
    has_many :attendees, through: :user_attendances, source: :user 
    has_many :absentees, through: :user_absences, source: :user

    validates :date, uniqueness: {scope: :course,  message: " - Course attendance on this date has already been taken."}

    def user_ids
        self.attendee_ids + self.absentee_ids
    end 

    def self.find_by_course_id(course_id)
        # self.all.select{|attendance| attendance.course_id == course_id}
        self.where(course_id: course_id)
    end 

    def self.find_by_user_id(user_id)
        # self.all.select{|attendance| (attendance.attendee_ids.include?(user_id) || attendance.absentee_ids.include?(user_id))}
        self.all.select{|attendance| attendance.user_ids.include?(user_id)}
        # self.where(user_id: user_id)
    end 

    def self.find_by_user_and_course(user_id, course_id)
        # attendances = self.find_by_user_id(user_id)
        self.where(course_id: course_id).select{|attendance| attendance.user_ids.include?(user_id)}
    end 

    # fixme: breaks if nil
    def set_absentees(attendee_ids)
        all_student_ids = course.get_user_ids('student')
        self.absentee_ids = all_student_ids - attendee_ids
    end 

    # fixme? breaks if .join is called on empty?
    def attendee_list
        self.attendees.collect{|attendee| attendee.name}.join(', ')
    end 

    def absentee_list
        self.absentees.collect{|absentee| absentee.name}.join(', ')
    end 

    # def self.sort_by_date(attendances)
    #     attendances.sort_by{|a| a.date}.reverse
    # end 

    def self.sort_by_date(attendances)
        lst = attendances.sort_by do |a|
            a.date.strftime("%s").to_i
        end
        lst.reverse 
    end 
end
