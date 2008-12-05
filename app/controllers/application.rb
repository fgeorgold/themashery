require 'lib/authorization_mixin'

class Application < Merb::Controller
  
  extend ::AuthorizationMixin
  
end