class SessionsController < ApplicationController

  def new
  end

  def create

    # .find_by == where.first
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      if user.two_factor_auth?
        session[:two_factor] = true
        # gen a pin
        user.generate_pin!
        #send to twilio, sms to uere's phone
        user.send_pin_to_twilio
        #show pin form
        redirect_to pin_path
      
      else #normal workflow
        login_user!(user)
      end
    else
      flash[:error]= "There's something wrong with your username or password."
      redirect_to login_path
      #render :new
      #redirect_to register_path
      #render 'sessions/news'
    end

  end


  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've logged out"
    redirect_to root_path
  end

  def pin #get post point to the same action

    access_denied if session[:two_factor].nil?

    if request.post?
      user = User.find_by pin: params[:pin]
      if user
        session[:two_factor] = nil
        #remove pin
        user.remove_pin!
        #normal login success
        login_user!(user)
      else
        flash[:error] = "Sorry, something is wrong with your pin nubmber."
        redirect_to pin_path 
      end

    end        
  end



  private

    def login_user!(user)
      # session[:user_id] will bake by the browser cookie
      session[:user_id] = user.id
      flash[:notice] = "You've logged in!"
      redirect_to root_path
    end 

end