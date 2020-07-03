class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|

      t.string :name 
      t.string :description
      t.integer :capacity
      t.string :location
      t.string :weekly_schedule
      t.time :military_start_time
      t.integer :duration

      t.timestamps
    end
  end
end
