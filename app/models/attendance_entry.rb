class AttendanceEntry < ApplicationRecord
    belongs_to :attendance 
    belongs_to :user 
end
