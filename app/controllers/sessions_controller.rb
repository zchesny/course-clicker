class SessionsController < ApplicationController
    def new 

    end 

    def create 
        case params[:role]
        when 'Admin'
            user = Admin.find_by(name: params[:name])
        when 'Teacher'
            user = Teacher.find_by(name: params[:name])
        when 'Student'
            user = Student.find_by(name: params[:name])
        else 
        end 

        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          session[:role] = params[:role].downcase
          redirect_to user 
        else # show form again
          redirect_to login_path, notice: "Your role [#{params[:role]}], name [#{params[:name]}], and/or password do not match."
        end 
    end 

    def destroy
        session.delete :user_id
        redirect_to root_path 
    end 
end
