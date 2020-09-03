class User
  PASSWORD_REQUIREMENTS = /\A
 (?=.{8,})
 (?=.*\d)
 (?=.*[a-z])
 (?=.*[A-Z])
 (?=.*[[:^alnum:]])
/x
  include ActiveModel::Model
  attr_accessor :username, :password
  validates :username, presence: true
  validates :password, :presence => true,
                       :length => {:within => 6..40},
                       :format => PASSWORD_REQUIREMENTS
end
