class TeachersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def index 
    end 

    def new 
        @user = Teacher.new 
    end 

    def create 
        @user = Teacher.new(user_params)

        if @user.save
            # Log them in 
            session[:user_id] = @user.id
            session[:role] = "teacher"
            redirect_to teacher_path(@user)
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
        @user = Teacher.find(params[:id])
    end 

    def user_params 
        params.require(:teacher).permit(:name, :password)
    end 


end
