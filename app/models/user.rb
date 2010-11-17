class User < ActiveRecord::Base

  acts_as_authentic do |c|
     c.require_password_confirmation = false
     c.validate_password_field = false
   end

end
