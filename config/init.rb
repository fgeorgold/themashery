# Go to http://wiki.merbivore.com/pages/init-rb
 
require 'config/dependencies.rb'

COUCHDB = 'themashery'
SERVER  = CouchRest.new
SERVER.default_database = COUCHDB

use_test :rspec
use_template_engine :haml
 
Merb::Config.use do |c|
  c[:use_mutex] = false
  c[:session_store] = 'cookie'  # can also be 'memory', 'memcache', 'container', 'datamapper
  
  # cookie session store configuration
  c[:session_secret_key]  = 'a09b57fc01d8ecf60801eb634fa6e8ae88236578'  # required for cookie session store
  c[:session_id_key] = '_themashery_session_id' # cookie session id key, defaults to "_session_id"
end
 
Merb::BootLoader.before_app_loads do
  # This will get executed after dependencies have been loaded but before your app's classes have loaded.
end
 
Merb::BootLoader.after_app_loads do
  # This will get executed after your app's classes have been loaded.
end
