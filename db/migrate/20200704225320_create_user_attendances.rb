class CreateUserAttendances < ActiveRecord::Migration[6.0]
  def change
    create_table :user_attendances do |t|
      t.integer :user_id
      t.integer :attendance_id

      t.timestamps
    end
  end
end
