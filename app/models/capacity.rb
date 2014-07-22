class Capacity < ActiveRecord::Base
  belongs_to :level
  belongs_to :login
end
