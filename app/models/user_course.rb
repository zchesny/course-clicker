class UserCourse < ApplicationRecord
    belongs_to :user 
    belongs_to :course

<<<<<<< HEAD
    def self.find_by_user_course(user_id, course_id)
        UserCourse.where("user_id = ? AND course_id = ?", user_id, course_id).first
    end

    def self.get_grade(user_id, course_id)
        UserCourse.find_by_user_course(user_id, course_id).grade
    end 
=======
    def self.set_user_courses_date(user_ids, course_id, date)
        binding.pry
        user_ids.each do |user_id|
            user_course = UserCourse.find_by_user_course(user_id, course_id)
            user_course.date = date
            user_course.save 
        end 
    end

    def self.find_by_user_course(user_id, course_id)
        UserCourse.where("user_id = ? AND course_id = ?", user_id, course_id)
    end
>>>>>>> df7056d... nonworking date with enrollment
end
