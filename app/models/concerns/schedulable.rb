module Schedulable

    module ClassMethods
    end

    module InstanceMethods
        def todays_schedule
            today = get_today[0, 3]
            if courses = self.courses
                courses.collect{|course| course if course.scheduled_on?(today)}.compact
            end 
        end

        def get_today
            Time.now.in_time_zone.strftime("%A")
        end

    end

end