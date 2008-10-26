module Merb
  module GlobalHelpers

    def show_link(object, link_text = "Show")
      allowed_actions = actions_for_user(@user, object.id)
      
      if(allowed_actions.include?(:show) || allowed_actions.include?(:all))
        link_to link_text, resource(object)
      end
    end
    
    def edit_link(object, link_text = "Edit")
      allowed_actions = actions_for_user(@user, object.id)
      
      if(allowed_actions.include?(:edit) || allowed_actions.include?(:all))
        link_to link_text, resource(object, :edit)
      end
    end
    
    def new_link(object, link_text = "New")
      allowed_actions = actions_for_user(@user, object.id)
      
      if(allowed_actions.include?(:new) || allowed_actions.include?(:all))
        link_to link_text, resource(object, :new)
      end
    end
    
    def add_separator_if(link_string)
      if link_string
        link_string + " |"
      end
    end
 
  end
end
