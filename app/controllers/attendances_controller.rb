class AttendancesController < ApplicationController
    #  before_action :set_course, only: [:show, :edit, :update, :destroy]
    before_action :set_attendance, only: [:show, :edit, :update, :destroy]
    before_action :require_login, only: [:new, :create, :show, :edit, :update, :destroy]

    def index 
        if params[:course_id]
        # course attendance index 
            @record = Course.find(params[:course_id])
            @attendances = Attendance.sort_by_date(Attendance.find_by_course_id(@record.id))
        # student attendance index 
        elsif params[:user_id]
            @record = User.find(params[:user_id])
            @attendances = Attendance.sort_by_date(Attendance.find_by_user_id(@record.id))
        # all attendance index
        else  
            @record = "all"
            @attendances = Attendance.sort_by_date(Attendance.all)
        end 
    end 

    def new 
        # only if logged in as admin or teacher 
        @course = Course.find(params[:course_id])
        @attendance = Attendance.new(course_id: params[:course_id])
    end 

    def create 
        @attendance = Attendance.new(attendance_params)
        @attendance.set_absentees(@attendance.attendee_ids)

        if @attendance.save
            redirect_to course_attendances_path(@attendance.course), notice: "Attendance for #{@attendance.course.name} on #{@attendance.date} was successfully taken."
        else 
            render :new 
        end 
    end 

    def show 
        if params[:course_id]
        # course attendance index 
            @record = Course.find(params[:course_id])
        # student attendance index 
        elsif params[:user_id]
            @record = User.find(params[:user_id])
        end 
    end 

    def edit 
        @course = Course.find(params[:course_id])
    end 

    def update 
        if @attendance.update(attendance_params)
            @attendance.set_absentees(@attendance.attendee_ids)
            @attendance.save
            redirect_to course_attendances_path(@attendance.course), notice: "Attendance for #{@attendance.course.name} on #{@attendance.date} was successfully updated."
        else 
            render :edit 
        end 
    end 

    def destroy 
        # todo: fix redirect depending on role 
        # todo: redirect to root_path (unless admin, then redirect to users_path)
        @attendance.destroy
        redirect_to attendances_path, notice: "Attendance for #{@attendance.course_id} on #{@attendance.date} was successfully deleted."
    end 

    private 

    def set_attendance
        @attendance = Attendance.find(params[:id])
    end 

    def attendance_params 
        params.require(:attendance).permit(
            :course_id,
            :date,
            attendee_ids: []
        )
    end 
end
