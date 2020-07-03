class SessionsController < ApplicationController
    def new 

    end 

    def create 
        # case params[:role]
        # when 'Admin'
        #     user = Admin.find_by(name: params[:name])
        # when 'Teacher'
        #     user = Teacher.find_by(name: params[:name])
        # when 'Student'
        #     user = Student.find_by(name: params[:name])
        # else 
        # end 
        user = User.find_by(name: params[:name])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect_to user_path(user) 
        else # show form again
            flash[:alert] = params[:name]
            redirect_to login_path, notice: "Your name and/or password do not match."
        end 
    end 

    def destroy
        session.delete :user_id
        redirect_to root_path 
    end 
end
