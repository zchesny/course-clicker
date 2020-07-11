module ApplicationHelper
    def first_created(obj)
        obj.created_at.strftime("%e %b %Y %H:%M%p")
    end

    def last_updated(obj)
        obj.updated_at.strftime("%e %b %Y %H:%M%p")
    end

    def format_date(date)
        date.strftime("%A, %d %b %Y")
    end

    def admin_or_teacher_ownership?(course)
        !!(current_user.role?('teacher') && current_user.courses.include?(course)) || (current_user.role?('admin'))
    end
end
