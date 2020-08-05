class CoursesController < ApplicationController
    before_action :set_course, only: [:show, :edit, :update, :destroy]
    before_action :require_login
    before_action :require_teacher, only: [:new, :create, :edit, :update, :destroy]
    before_action :require_ownership, only: [:edit, :update, :destroy]

    def index 
        @courses = Course.all 
        @courses = Course.filter_by_schedule(@courses, params[:schedule]) if !params[:schedule].blank?
        @courses = Course.filter_by_location(@courses, params[:location]) if !params[:location].blank?
        @courses = Course.filter_by_time(@courses, params[:time]) if !params[:time].blank?
        @courses = Course.filter_by_teacher(@courses, params[:user_id]) if !params[:user_id].blank?
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
            if params[:course][:weekly_schedule]
                ws = params[:course][:weekly_schedule] 
            else
                ws = [""]
            end 
            @course.weekly_schedule_attribute = ws
            @course.save
            redirect_to course_path(@course), notice: "#{@course.name} was successfully updated."
        else 
            render :edit 
        end 
    end 

    def destroy 
        # delete associated attendances 
        Attendance.where(course: @course).each{|a| a.destroy }
        # then delete the course 
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
