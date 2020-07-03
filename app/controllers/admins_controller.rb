class AdminsController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def index 
    end 

    def new 
        @user = Admin.new 
    end 

    def create 
        @user = Admin.new(user_params)

        if @user.save
            # Log them in 
            session[:user_id] = @user.id
            session[:role] = "admin"
            redirect_to admin_path(@user)
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
        @user = Admin.find(params[:id])
    end 

    def user_params 
        params.require(:admin).permit(:name, :password)
    end 

end
