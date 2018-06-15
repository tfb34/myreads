class SessionsController < ApplicationController
  def new
  end

  #search for user here
  def create
  	@user = User.find_by(email: params[:email].downcase).try(:authenticate, params[:password])
  	if @user
  		login(@user)

		remember(@user) unless params[:remember_me].nil?
		params[:remember_me] == '1' ? remember_me(@user) : forget(@user)
  		flash[:success] = "Welcome back!"
  		redirect_to @user
  	else
  		flash[:danger] = "Invalid email/password combination."
  		render 'new'
  	end
  end

  def destroy

  	logout if logged_in?
  	redirect_to root_url
  end


end
