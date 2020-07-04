class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def index 
        @users = User.all
    end 

    def new 
        @user = User.new 
    end 

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
    end 

    def destroy 
    end 

    private 

    def set_user 
        @user = User.find(params[:id])
    end 

    def user_params 
        params.require(:user).permit(:name, :password, :role)
    end 
end
