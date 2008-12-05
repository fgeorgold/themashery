module Authorization
  module AuthorizedController
    def user_role_for_object(user, object_id = nil)
      return Role::Guest
    end
    
    def actions_for_role(role)
      return [:all]
    end
    
    def actions_for_user(user, object_id = nil)
      return actions_for_role(user_role_for_object(user, object_id))
    end
  end
end
