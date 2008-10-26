require 'lib/authorization_mixin'

class Application < Merb::Controller
  
  include AuthorizationMixin
  
end