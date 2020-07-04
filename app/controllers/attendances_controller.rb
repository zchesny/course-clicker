class AttendancesController < ApplicationController
    before_action :set_course, only: [:show, :edit, :update, :destroy]
    before_action :require_login, only: [:new, :create, :show, :edit, :update, :destroy]

    def index 
    end 

    def new 
        # only if logged in as admin or teacher 
        @attendance = Attendance.new 
    end 

    def create 

        @attendance = Attendance.new(attendance_params)

        if @attendance.save
            redirect_to attendance_path(@attendance), notice: "Attendance for #{@attendance.course_id} on #{@attendance.date} was successfully taken."
        else 
            render :new 
        end 
    end 

    def show 
    end 

    def edit 
    end 

    def update 
        if @attendance.update(attendance_params)
            redirect_to attendances_path(@attendance)
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
            :user_id,
            :date
        )
    end 
end
