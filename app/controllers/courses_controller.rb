class CoursesController < ApplicationController
    before_action :set_course, only: [:show, :edit, :update, :destroy]
    before_action :require_login, only: [:new, :create, :show, :edit, :update, :destroy]

    def index 
    end 

    def new 
        # only if logged in as admin or teacher 
        @course = Course.new 
    end 

    def create 

        @course = Course.new(course_params)
        @course.weekly_schedule_attribute = params[:course][:weekly_schedule]

        if @course.save
            redirect_to course_path(@course), notice: "#{@course.name} was successfully created."
        else 
            render :new 
        end 
    end 

    def show 
    end 

    def edit 
    end 

    def update 
        if @course.update(course_params)
            redirect_to course_path(@course), notice: "#{@course.name} was successfully updated."
        else 
            render :edit 
        end 
    end 

    def destroy 
        @course.destroy
        redirect_to courses_path, notice: "#{@course.name} was successfully deleted."
    end 

    private 

    def set_course 
        @course = Course.find(params[:id])
    end 

    def course_params 
        params.require(:course).permit(
            :name,
            :description,
            :capacity,
            :location,
            :military_start_time,
            :start_time,
            :duration,
            :end_time,
            user_ids: []
        )
    end 
end
