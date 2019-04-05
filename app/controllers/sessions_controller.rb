class SessionsController < ApplicationController
    def new 
        render :new 
    end

    def create 
      @my_user = User.find_by_credentials(params[:email], params[:password])

      if @my_user
        login(@my_user)
        redirect_to user_url(@my_user) 
        #redirects to the show page via show url
      else 
        render :new 
      end
        
        #look for the user 
        #if they exist => log them in ...(give them a new session token?)
        #redirect them via the show route 
        #if they don't, show them the new form again 
    end

end
