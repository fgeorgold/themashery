module Authorization
  
  module AuthorizedController
    def authorized_resource
      extend ::Authorization::AuthorizedResource
    end
  end
  
  module AuthorizedResource
    def model_class
      Object.full_const_get(self.controller_name.camel_case.singular)
    end

    def user_role_for_object(user, object_id = nil)
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
  end
end
