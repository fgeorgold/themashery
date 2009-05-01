# This is a default user class used to activate merb-auth.  Feel free to change from a User to 
# Some other class, or to remove it altogether.  If removed, merb-auth may not work by default.
#
# Don't forget that by default the salted_user mixin is used from merb-more
# You'll need to setup your db as per the salted_user mixin, and you'll need
# To use :password, and :password_confirmation when creating a user
#
# see merb/merb-auth/setup.rb to see how to disable the salted_user mixin
# 
# You will need to setup your database and create a user.
class User < CouchRest::ExtendedDocument
  include CouchRest::Validation
  
  # Callbacks
  save_callback :before, :process_password
  
  # Schema
  unique_id :user_id
  property  :email
  property  :salt
  property  :crypted_password
  
  timestamps!
  
  # Views
  view_by :email
  
  # Validations
  validates_present      :email
  validates_present      :password, :if => proc {|o| o.password_required? }
  validates_is_confirmed :password, :if => proc {|o| o.password_required? }
  
  validates_length       :email,    :within => 3..100
  validates_length       :password, :within => 4..72, :if => proc {|o| o.password_required? }
  validates_format       :email,    :as => :email_address
  
  def process_password
    if (valid? && password_required?)
      encrypt_password
      true
    else
      false
    end
  end
  
  def self.authenticate(email, password)
    @user = User.by_email(:key => email, :limit => 1).first
    @user && @user.authenticated?(password) ? @user : nil
  end
  
  def user_id
    "user:#{email}"
  end
  
end
