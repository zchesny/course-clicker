class Cleanup < ActiveRecord::Migration[6.0]
  def change
    drop_table :enrollments 
    drop_table :students 
    drop_table :teacher_courses 
    drop_table :teachers 
    drop_table :user_absences 
    drop_table :user_attendances 
  end
end
