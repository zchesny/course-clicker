class ApplicationController < ActionController::Base	
    protect_from_forgery with: :exception	

    # Methods you build in controllers do not permeate	
    # to action view unless you define as a helper 	
    helper_method :logged_in?	
    helper_method :current_user	
    

    # helper methods
    def logged_in?	
        # !!session[:user_id]	
        !!current_user 	
    end 	

    def current_user 	
      # the first time, you fire sql	
      # subsequent times it just looks to see if @current_user is already set 	
      @current_user ||= User.find(session[:user_id]) if session[:user_id]	
    end 	

    # authentication methods
    def require_login
        redirect_to root_path, notice: 'Sorry, you must be logged in for access.' if !logged_in?	
    end 	

    # this produced a syntax error
    # def require_role(role)
    #     require_login
    #     redirect_to user_path(current_user) if !current_user.role?(role)	
    # end 

    # before_action :require_login, only: :require_admin
    def require_admin
        # require_login
        return redirect_to root_path, notice: 'Sorry, you must be logged in for access.' if !logged_in?	
        redirect_to user_path(current_user), notice: 'Sorry, an Admin role is required for access.' if !current_user.role?('admin')	
    end 

    # an admin has the same abilities as a teacher 
    # require_teacher(or_admin)
    def require_teacher
        # require_login
        return redirect_to root_path, notice: 'Sorry, you must be logged in for access.' if !logged_in?	
        redirect_to user_path(current_user), notice: 'Sorry, a Teacher or Admin role is required for access.' if (!current_user.role?('admin')	&& !current_user.role?('teacher'))
    end 

    # a teacher can only edit courses and attendance pertaining to their own classes 
    # an admin can edit anything
    def require_ownership
        return redirect_to root_path, notice: 'Sorry, you must be logged in for access.' if !logged_in?	
        if !((current_user.role?('admin')) || (current_user.role?('teacher') && current_user.courses.include?(@course)))
            redirect_to user_path(current_user), notice: 'Sorry, you must teach this course or be and Admin for access.' 
        end
        # we don't redirect (if admin) or (if teacher and teacher.courses.include?(course))
    end 

    def require_student 
        return redirect_to root_path, notice: 'Sorry, you must be logged in for access.' if !logged_in?	
        redirect_to user_path(current_user), notice: 'Sorry, this feature is only available for students.' if !@user.role?('student')
    end 
	
end