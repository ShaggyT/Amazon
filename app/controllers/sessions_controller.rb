class SessionsController < ApplicationController
  def new
  end

  def create
  user = User.find_by(email: session_params[:email])

  if user && user.authenticate(session_params[:password])
    session[:user_id] = user.id

    flash[:notice] = 'Thank you for sign in!'
    redirect_to home_path
  else
    # `flash.now` behaves differently than regular flash. The message will instead
    # only appear for the current request and not any further requests.
    flash.now[:alert] = 'Wrong email or password!'
    render :new
  end
  end

  def destroy
    session[:user_id] = nil
    # When using `redirect_to` you can specify a flash message
    # as argument such as `notice: 'Signed out!'` or `alert: 'Failed!'`
    # That is equivalent to:
    # flash[:notice] = 'Signed out!'
    # flash[:alert] = 'Failed!'
    redirect_to home_path, notice: 'Signed Out!'
  end

  private
  def session_params
   params.require(:session).permit(:email, :password)
  end

end
