class UserCoursesController < ApplicationController
    before_action :set_user_course, only: [:edit, :update]
    def edit 
    end 

    def update 
        if @user_course.update(user_course_params)
            @user_course.save
            redirect_to user_path(@user_course.user), notice: "#{@user_course.user.name}'s grade for #{@user_course.course.name} was successfully updated."
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
