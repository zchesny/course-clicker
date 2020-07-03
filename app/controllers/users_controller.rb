class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def index 
    end 

    def new 
        @user = User.new 
    end 

    def create 
        @user = User.new(user_params)
        if @user.save
            # Log them in 
            session[:user_id] = @user.id
            redirect_to user_path(@user)
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
