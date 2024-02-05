class AttendancesController < ApplicationController
    before_action :set_attendance, only: [:show, :edit, :update, :destroy]
    before_action :require_login
    before_action :require_teacher, only: [:new, :create, :edit, :update, :destroy]
    # before_action :require_ownership, only: [:new, :create, :edit, :update, :destroy]

    def index 
        #fixme: breaks if you filter by something that doesn't exist 
        # uses filter in /attendances, filter both
        if !params[:course_id].blank? && !params[:user_id].blank?
            @user = User.find(params[:user_id])
            @course = Course.find(params[:course_id])
            @record = "#{@user.name} in #{@course.name}"
            @attendances = Attendance.includes(:course, :users, :attendance_entries)
                             .where(course_id: @course.id)
                             .where(users: { id: @user.id })
        # course attendance index
        elsif !params[:course_id].blank?
            require_teacher
            @record = Course.find(params[:course_id])
            @attendances = Attendance.includes(:course, :users, :attendance_entries)
                             .where(course_id: @record.id)
                             .sort_by_date
        # student attendance index 
        elsif !params[:user_id].blank?
            # require ownership 
            @record = User.find(params[:user_id])
            @user = @record 
            require_student
            if current_user.role?('student') && @user != current_user
                redirect_to user_path(current_user), notice: 'Sorry, you may only view your own attendance record.'
            end
            @attendances = Attendance.includes(:course, :users, :attendance_entries)
                             .where(users: { id: @record.id })
                             .sort_by_date
        # all attendance index
        else  
            require_teacher
            @record = "All Courses"
            @attendances = Attendance.includes(:course, :users, :attendance_entries)
                            .sort_by_date
        end 
    end 

    # example url: http://localhost:3000/courses/15/attendances/new
    def new 
        # only if logged in as admin or teacher 
        @attendance = Attendance.new(course_id: params[:course_id])
        @course = @attendance.course 
        @attendance.course.get_users('student').each do |student|
            @attendance.attendance_entries.build(user_id: student.id)
        end 
        require_ownership
    end 

    def create 
        @attendance = Attendance.new(attendance_params)
        if @attendance.save
            redirect_to course_attendances_path(@attendance.course), notice: "Attendance for #{@attendance.course.name} on #{@attendance.date} was successfully taken."
        else 
            render :new 
        end 
    end 

    def show 
        @course = @attendance.course
        require_ownership
    end 

    def edit 
        @course = @attendance.course
        require_ownership
    end 

    def update 
        # binding.pry
        if @attendance.update(attendance_params)
            # @attendance.set_absentees(@attendance.attendee_ids)
            @attendance.save
            redirect_to course_attendances_path(@attendance.course), notice: "Attendance for #{@attendance.course.name} on #{@attendance.date} was successfully updated."
        else 
            render :edit 
        end 
    end 

    def destroy 
        @attendance.destroy
        redirect_to attendances_path, notice: "Attendance for #{@attendance.course.name} on #{@attendance.date} was successfully deleted."
    end 

    private 

    def set_attendance
        @attendance = Attendance.find(params[:id])
    end 

    def attendance_params 
        params.require(:attendance).permit(
            :id, 
            :course_id,
            :date,
            attendee_ids: [],
            attendance_entries_attributes: [
                :id, 
                :user_id,
                :status 
            ]
        )
    end 
end
