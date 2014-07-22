class Payment < ActiveRecord::Base
  belongs_to :turn
  belongs_to :level
  belongs_to :login
  belongs_to :beneficiary, class_name: 'Login', foreign_key: 'beneficiary_id'

  validates :amount,:gateway, presence: true

end
