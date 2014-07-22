class Turn < ActiveRecord::Base

  belongs_to :login
  belongs_to :level
  has_many :payments


end
