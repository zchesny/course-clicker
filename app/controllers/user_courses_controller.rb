class UserCoursesController < ApplicationController
    before_action :set_user_course, only: [:edit, :update]
    before_action :require_login
    before_action :require_teacher, only: [:new, :create, :edit, :update, :destroy]

    def edit 
        @course = @user_course.course 
        require_ownership
    end 

    # example url: http://localhost:3000/user_courses/61/edit
    def update 
        if @user_course.update(user_course_params)
            @user_course.save
            redirect_to course_path(@user_course.course), notice: "#{@user_course.user.name}'s grade for #{@user_course.course.name} was successfully updated."
        else 
            render :edit 
        end 
    end 

    private 

    def set_user_course 
        @user_course = UserCourse.find(params[:id])
    end 

    def user_course_params 
        params.require(:user_course).permit(
            :grade
        )
    end 
end
