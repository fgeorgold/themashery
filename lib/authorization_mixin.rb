module AuthorizationMixin
  # This is all stuff for authorization
  # Neato stuff huh

  
  
  

  # roles and actions are separated out
  # for convenience in the controller
  # we won't always want to change both
  def model_class
    Object.full_const_get(self.controller_name.camel_case.singular)
  end
  
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
    when Role::User: [:index, :show, :new, :create]
    when Role::Owner: [:all]
    when Role::Admin: [:all]
    end
  end

  def actions_for_user(user, object_id = nil)
    actions_for_role(role_for_object(user, object_id))
  end
  
  # these are a couple of link helpers that should be useful
  def auth_link(args = {})
    if args[:resource].is_a?(Symbol)
      controller = args[:controller] || args[:resource].to_s
      object = nil
      requested_action = args[:action] || :index
    elsif args[:resource]
      controller = args[:controller] || args[:resource].class.to_s.snake_case.plural
      object = args[:resource]
      requested_action = args[:action] || :show
    elsif args[:controller]
      controller = args[:controller]
      object = nil
      requested_action = args[:action] || :index
    else
      return nil
    end
    controller_class = Object.full_const_get(controller.camel_case)
    role = controller_class.role_for_object(@user, object)
    actions = controller_class.actions_for_role(role)
    text = args[:text] || requested_action.to_s.camel_case
    
    if actions.include?(requested_action)
      if object
        link_to text, resource(object, requested_action)
      else
        link_args = {:controller => controller, :action => requested_action}
        link_args[:id] = args[:id] if args[:id]
        link_to text, url(link_args)
      end
    else
      return nil
    end
  end


end