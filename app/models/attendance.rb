class Attendance < ApplicationRecord
    belongs_to :course 
    has_many :attendance_entries 
    has_many :users, through: :attendance_entries 

    validates :date, presence: true 
    validates :date, uniqueness: {scope: :course,  message: " - Course attendance on this date has already been taken."}

    accepts_nested_attributes_for :attendance_entries, allow_destroy: true

    def get_users(status)
        users.where(attendance_entries: { status: status }).order(:name)
    end

    def absentee_list
      get_users('absent').pluck(:name).join(', ')
    end

    # Filtering and sorting methods
    scope :sort_by_date, -> { order(date: :desc) }
    scope :find_by_course_id, ->(course_id) { where(course_id: course_id) }
    scope :find_by_user_id, ->(user_id) { joins(:users).where(users: { id: user_id }) }
    scope :find_by_user_and_course, ->(user_id, course_id) { find_by_course_id(course_id).find_by_user_id(user_id) }
    scope :past_year, -> { where(date: (Date.today - 1.year)..Date.today) }
end
