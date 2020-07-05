class AddUniqueIndexToAttendances < ActiveRecord::Migration[6.0]
  def change
    add_index :attendances, [:course_id, :date], unique: true 
  end
end
