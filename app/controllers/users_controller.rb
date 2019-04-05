class UsersController < ApplicationController
    
    def new
    render :new
    end

    def edit 

    end

    def index 

    end
    
    def show 
        @user = User.find_by(id: params[:id])

        if @user 
            render :show 
        else 
            render json: "No user found.", status: 404
        end
    end
  

    private 
    def user_params
        params.require(:user).permit(:email, :passowrd)
    end
end
