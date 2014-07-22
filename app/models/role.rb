class Role < ActiveRecord::Base
  has_many :logins
end
