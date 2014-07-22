class Login < ActiveRecord::Base
  before_create :set_default_role
  after_create :assign_capacity

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :turns
  has_many :payments
  has_many :levels
  has_and_belongs_to_many :messages
  has_many :notifications
  belongs_to :role
  has_many :capacities
  has_many :referrals, class_name: "Login",
           foreign_key: "sponsor_id"
  belongs_to :sponsor, class_name: "Login"


  #Validations
  validates :first_name, :last_name, presence: true, length: {maximum: 24}
  validates :username, presence: true, uniqueness: true
  validates :identification, presence: true, uniqueness: true, numericality: true, length: {maximum: 18}
  validates :number_account, presence: true, uniqueness: true, numericality: true
  validates :account_type, presence: true


  private
  def set_default_role
    self.role ||= Role.find_by_name('beginner')
  end

  def assign_capacity
    self.capacities.create login_id: self.id
  end


end
