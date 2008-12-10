module Merb
  module GlobalHelpers
    
    def add_separator_if(link_string)
      if link_string
        link_string + " |"
      end
    end
    
    def authz_new_link(target, text = "New")
      klass = Object.full_const_get(target.to_s.singular.camel_case)
      if session.user.authorized?(:create, :target => klass)
        link_to text, resource(target, :new)
      end
    end
    
    def authz_edit_link(target, text = "Edit")
      if session.user.authorized?(:update, :target => target)
        link_to text, resource(target, :edit)
      end
    end
    
    def authz_delete_link(target, text = "Delete")
      if session.user.authorized?(:delete, :target => target)
        delete_button(target, text)
      end
    end
    
    def authz_show_link(target, text = "Show")
      if target.is_a?(Symbol)
        auth_target = Object.full_const_get(target.to_s.singular.camel_case)
      else
        auth_target = target
      end
      
      if session.user.authorized?(:read, :target => auth_target)
        link_to text, resource(target)
      end
    end
    
  end
end
