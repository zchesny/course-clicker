class AddGradeToUserCourses < ActiveRecord::Migration[6.0]
  def change
    add_column :user_courses, :grade, :string, default: "N/A"
  end
end
