class Attendance < ApplicationRecord
    belongs_to :course 
    has_many :attendance_entries 
    has_many :users, through: :attendance_entries 

    validates :date, presence: true 
    validates :date, uniqueness: {scope: :course,  message: " - Course attendance on this date has already been taken."}

    accepts_nested_attributes_for :attendance_entries, allow_destroy: true

    def get_users(status)
        users.includes(:attendance_entries).where(attendance_entries: { status: status }).order(:name)
    end

    def absentee_list
        get_users('absent').collect{|absentee| absentee.name}.join(', ')
    end 
    
    # filtering and sorting methods 
    def self.sort_by_date
        order(date: :desc)
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
end
