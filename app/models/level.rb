class Level < ActiveRecord::Base
  has_many :logins
  has_many :turns
  has_many :payments

end
