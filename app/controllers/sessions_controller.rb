class SessionsController < ApplicationController
    def new 
        if logged_in?
            redirect_to user_path(current_user), notice: "You are already logged in"
        end 
    end 

    def create 
        @user = User.find_or_create_by(name: auth['info']['name']) do |u|
            u.name = auth['info']['name']
            u.role = 'Teacher'
            u.password = 'pass'
        end 
        binding.pry
        session[:user_id] = @user.id
        redirect_to user_path(current_user)
        # user = User.find_by(name: params[:name])
        # if user && user.authenticate(params[:password])
        #     session[:user_id] = user.id
        #     redirect_to user_path(current_user) 
        # else # show form again
        #     flash[:alert] = params[:name]
        #     redirect_to login_path, notice: "Sorry, we could not find a user with a matching name and/or password."
        # end 
    end 

    def destroy
        session.delete :user_id
        redirect_to root_path 
    end 

    private 

    def auth 
        request.env['omniauth.auth']
    end 
end
