class UserCourse < ApplicationRecord
    belongs_to :user 
    belongs_to :course

    def self.find_by_user_course(user_id, course_id)
        UserCourse.where("user_id = ? AND course_id = ?", user_id, course_id).first
    end

    def self.get_grade(user_id, course_id)
        UserCourse.find_by_user_course(user_id, course_id).grade
    end 
end
