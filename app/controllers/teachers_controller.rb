class TeachersController < ApplicationController
    before_action :set_teacher, only: [:show, :edit, :update, :destroy]

    def index 
    end 

    def new 
        @teacher = Teacher.new 
    end 

    def create 
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

    def set_teacher 
        @teacher = Teacher.find(params[:id])
    end 

    def teacher_params 
        params.require(:teacher).permit(:name, :password)
    end 


end
