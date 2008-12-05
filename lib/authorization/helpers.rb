module Authorization
  module Helpers
    
    class ::Merb::Controller::NotAllowed < ::Merb::ControllerExceptions::MethodNotAllowed; end
    
    protected
    def ensure_authorized
      
      if session.authenticated?
        allowed_actions = actions_for_user(session.user, params[:id])
      else
        allowed_actions = actions_for_user(nil, params[:id])
      end
        
      if !(allowed_actions.include?(params[:action].to_sym) || allowed_actions.include?(:all))
        if session.authenticated?
          raise Merb::Controller::NotAllowed
        else
          raise Merb::Controller::Unauthenticated
        end
      end
    end
    
  end
end
