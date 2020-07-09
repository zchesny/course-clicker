class ApplicationController < ActionController::Base	
    protect_from_forgery with: :exception	

    # Methods you build in controllers do not permeate	
    # to action view unless you define as a helper 	
    helper_method :admin? 	
    helper_method :teacher?	
    helper_method :student?	
    helper_method :logged_in?	
    helper_method :current_user	

    def logged_in?	
        # !!session[:user_id]	
        !!current_user 	
    end 	

    def current_user 	
      # the first time, you fire sql	
      # subsequent times it just looks to see if @current_user is already set 	
      @current_user ||= User.find(session[:user_id]) if session[:user_id]	
    end 	

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
	
end