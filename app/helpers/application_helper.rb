module ApplicationHelper
    def first_created(obj)
        obj.created_at.strftime("%e %b %Y %H:%M%p")
    end

    def last_updated(obj)
        obj.updated_at.strftime("%e %b %Y %H:%M%p")
    end
end
