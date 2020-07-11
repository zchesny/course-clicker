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
            @attendances = Attendance.find_by_user_and_course(@user.id, @course.id)
        # course attendance index
        elsif !params[:course_id].blank?
            require_teacher
            @record = Course.find(params[:course_id])
            @attendances = Attendance.sort_by_date(Attendance.find_by_course_id(@record.id))
        # student attendance index 
        elsif !params[:user_id].blank?
            # require ownership 
            @record = User.find(params[:user_id])
            @user = @record 
            require_student
            if current_user.role?('student') && @user != current_user
                redirect_to user_path(current_user), notice: 'Sorry, you may only view your own attendance record.'
            end
            @attendances = Attendance.sort_by_date(Attendance.find_by_user_id(@record.id))
        # all attendance index
        else  
            require_teacher
            @record = "All Courses"
            @attendances = Attendance.sort_by_date(Attendance.all)
        end 
    end 

    def new 
        # only if logged in as admin or teacher 
        @attendance = Attendance.new(course_id: params[:course_id])
        @course = @attendance.course
        require_ownership
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
         # course attendance index 
        if params[:course_id]
            @record = Course.find(params[:course_id])
            # if student, don't allow unless its their course
            # http://localhost:3000/courses/2/attendances/15
            if current_user.role?('student') && !current_user.courses.include?(@record)
                redirect_to user_path(current_user), notice: 'Sorry, you may only view attendance for courses in which you are enrolled.'
            end
        # student attendance index 
        elsif params[:user_id]
            @record = User.find(params[:user_id])
            @user = @record
            # if student, don't allow to view other students 
            # http://localhost:3000/users/6/attendances
            if current_user.role?('student') && @user != current_user
                redirect_to user_path(current_user), notice: 'Sorry, you may only view your own attendance record.'
            end
        end 
    end 

    def edit 
        @course = Course.find(params[:course_id])
        @attendance = Attendance.new(course_id: params[:course_id])
        @course = @attendance.course
        require_ownership
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
        redirect_to attendances_path, notice: "Attendance for #{@attendance.course.name} on #{@attendance.date} was successfully deleted."
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
