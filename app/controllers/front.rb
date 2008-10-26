class Front < Application

  # ...and remember, everything returned from an action
  # goes to the client...
  def index
    if session.authenticated?
      render
    else
      render :guest_index
    end
  end
  
  def guest_index
    render
  end
  
end
