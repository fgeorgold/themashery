# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_themashery_session',
  :secret      => 'fc53844469494f4b925270b80b2e3c24168fde87be7f2d0feb3c16409acc47452966e01e331711e80f4aae034fe03a4ae3fd43815caf011c70a61acd62c2ccee'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
