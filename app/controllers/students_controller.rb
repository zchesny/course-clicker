class StudentsController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def index 
    end 

    def new 
        @user = Student.new 
    end 

    def create 
        @user = Student.new(user_params)

        if @user.save
            # Log them in 
            session[:user_id] = @user.id
            session[:role] = "student"
            redirect_to student_path(@user)
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
        @user = Student.find(params[:id])
    end 

    def user_params 
        params.require(:student).permit(:name, :password)
    end 

end
