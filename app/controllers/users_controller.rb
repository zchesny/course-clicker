class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def index 
        @users = User.all
    end 

    def new 
        @user = User.new 
    end 

    before_action :protect_registration, only: [:create]

    def create 
        @user = User.new(user_params)
        if @user.save
            # Admins can create new users without needing to be logged in as the new user
            if logged_in? && current_user.role?('admin')
                redirect_to users_path, notice: "#{@user.name} [#{@user.role}] successfully created."
            else # Log them in 
                session[:user_id] = @user.id
                redirect_to user_path(@user)
            end 
        else 
            render :new 
        end 
    end 

    def show 
    end 

    def edit 
    end 

    def update
        if @user.update(user_params)
            redirect_to user_path(@user), "#{@user.name} [#{@user.role}] successfully updated."
        else 
            render :edit 
        end  
    end 

    def destroy 
        # todo: logout if a user is deleting themselves (redirect depending on role)
        # if student or teacher, logout and redirect else users_path (admiN)
        # todo: redirect to root_path (unless admin, then redirect to users_path)
        @user.destroy
        redirect_to users_path, notice: "#{@user.name} was successfully deleted."
    end 

    private 

    def set_user 
        @user = User.find(params[:id])
    end 

    def user_params 
        params.require(:user).permit(:name, :password, :role, :code)
    end 

    def validate_registration
        binding.pry
        !!(params[:user][:code] == ENV['ADMIN_CODE'] && params[:user][:role] == 'Admin') || 
        (params[:user][:code] == ENV['TEACHER_CODE'] && params[:user][:role] == 'Teacher') || 
        (params[:user][:code] == ENV['STUDENT_CODE'] && params[:user][:role] == 'Student')
    end 

    def protect_registration
        if !validate_registration
            redirect_to new_user_path, notice: 'Sorry, the registration code is invalid for the role in which you are registering'
        end 
    end 
end
