class CreateAttendanceEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :attendance_entries do |t|
      t.integer :attendance_id 
      t.integer :user_id 
      t.string :status 
      t.timestamps
    end
  end
end
