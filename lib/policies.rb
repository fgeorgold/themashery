class Merb::Authorization
  module Policies
    class Admin
      def general_policy(operator, options)
        operator.admin?
      end
      
      def instance_policy(operator, instance, options)
        general_policy(operator, options)
      end
    end
    
    class Owner
      def instance_policy(operator, instance, options)
        instance.respond_to?(:user_id) && instance.user_id == operator.id
      end
    end
    
    class User
      def general_policy(operator, options)
        true
      end
      
      def instance_policy(operator, instance, options)
        general_policy(operator, options)
      end
    end
  end
  
  global_policies do
    for_label(:admin).use_policy("Admin")
    for_label(:owner).use_policy("Owner")
    for_label(:user).use_policy("User")
  end
end