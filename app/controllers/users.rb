class Users < Application

  # ...and remember, everything returned from an action
  # goes to the client...
  def new
    only_provides :html
    @user = User.new
    render
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect '/', :message => {:notice => "Welcome to The Mashery"}
    else
      render :new
    end
  end
  
end
