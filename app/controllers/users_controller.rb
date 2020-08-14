class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :require_login, only: [:index, :show, :edit, :update, :destroy]

    def most_courses 
    end 

    before_action :require_admin, only: :index
    def index 
        if !params[:role].blank?
            flash[:alert] = params[:role]
            @users = User.where(role: params[:role])
        else 
            @users = User.all
        end
    end 

    before_action :admin_registration, only: :new
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
        if current_user != @user 
            redirect_to user_path(current_user), notice: 'Sorry, an Admin role is required for access.' unless current_user.role?('admin')
        end 
    end 

    def edit 
        if current_user != @user 
            redirect_to user_path(current_user), notice: 'Sorry, an Admin role is required for access.' unless current_user.role?('admin')
        end 
    end 

    def update
        if @user.update(user_edit_params)
            redirect_to user_path(@user), notice: "Successfully updated user information for #{@user.name} [#{@user.role}]."
        else 
            render :edit 
        end  
    end 

    def destroy 
        # todo: logout if a user is deleting themselves (redirect depending on role)
        # if student or teacher, logout and redirect else users_path (admiN)
        # todo: redirect to root_path (unless admin, then redirect to users_path)
        @user.destroy
        # redirect_to users_path, notice: "#{@user.name} was successfully deleted."
        # binding.pry
        if current_user != @user
            redirect_to users_path, notice: "#{@user.name} was successfully deleted."
        else 
            redirect_to root_path, notice: "Your profile has been successfully deleted."
        end 
    end 

    private 

    def set_user 
        @user = User.find(params[:id])
    end 

    def user_params 
        params.require(:user).permit(:name, :password, :role, :code)
    end 

    def user_edit_params
        params.require(:user).permit(:name, :password)
    end 

    def validate_registration
        !!(params[:user][:code] == ENV['ADMIN_CODE'] && params[:user][:role] == 'Admin') || 
        (params[:user][:code] == ENV['TEACHER_CODE'] && params[:user][:role] == 'Teacher') || 
        (params[:user][:code] == ENV['STUDENT_CODE'] && params[:user][:role] == 'Student')
    end 

    def protect_registration
        if !validate_registration
            redirect_to new_user_path, notice: 'Sorry, the registration code is invalid for the role in which you are registering'
        end 
    end 

    def admin_registration
        if logged_in? && !current_user.role?('admin')
            redirect_to user_path(current_user), notice: 'Sorry, you must be an Admin to register a new user.'
        end
    end 
end
