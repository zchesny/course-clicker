class CreateUserAbsences < ActiveRecord::Migration[6.0]
  def change
    create_table :user_absences do |t|
      t.integer :user_id
      t.integer :attendance_id

      t.timestamps
    end
  end
end
