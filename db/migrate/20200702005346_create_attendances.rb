class CreateAttendances < ActiveRecord::Migration[6.0]
  def change
    create_table :attendances do |t|
      t.integer :course_id
      t.integer :user_id  

      t.date :date 

      t.timestamps
    end
  end
end
