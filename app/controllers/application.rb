class Application < Merb::Controller
  
  # This is all stuff for authorization
  # Neato stuff huh

  class ::Merb::Controller::NotAllowed < ::Merb::ControllerExceptions::MethodNotAllowed; end
  
  # roles and actions are separated out
  # for convenience in the controller
  # we won't always want to change both
  def role_for_object(user, object_id = nil)
    if !user
      return Role::Guest
    elsif user.is_admin
      return Role::Admin
    elsif !object_id
      return Role::User
    end
    
    @model = model_class.get(object_id)
    
    if @model && @model.user_id == user.id
      return Role::Owner
    else
      return Role::User
    end
  end
    
  def actions_for_role(role)
    case role
    when Role::Guest: [:index, :show]
    when Role::User:  [:index, :show, :new, :create]
    when Role::Owner: [:all]
    when Role::Admin: [:all]
    end
  end
  
  def actions_for_user(user, object_id = nil)
    actions_for_role(role_for_object(user, object_id))
  end
  
  protected
  def ensure_authorized
    
    if session.authenticated?
      @user = session.user
    else
      @user = nil
    end
    
    allowed_actions = actions_for_user(@user, params[:id])
    
    if !(allowed_actions.include?(params[:action].to_sym) || allowed_actions.include?(:all))
      if @user
        raise Merb::Controller::NotAllowed
      else
        raise Merb::Controller::Unauthenticated
      end
    end
  end
  
end