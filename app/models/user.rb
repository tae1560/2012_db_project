class User < ActiveRecord::Base
  attr_accessible :name, :address, :email, :phone, :join_date, :roll, :login_id, :password, :password_confirmation

  has_one :requestor, :foreign_key => :id
  has_one :administrator, :foreign_key => :id
  has_one :sw_developer, :foreign_key => :id
  has_one :evaluator, :foreign_key => :id

  validates :name, :presence => true
  validates :login_id, :presence => true, :uniqueness => true
  validates :password, :presence => true, :length => { :in => 3..20 }
  validates_confirmation_of :password
  validates :roll, :presence => true
  validates :email, :presence => true
  validates :address, :presence => true
  validates :phone, :presence => true

  before_save :encrypt_password

  def encrypt_password
    if self.password.present?
      self.password = Digest::SHA1.hexdigest(self.password)
    end
  end

  def self.authenticate(login_id="", password="")
    user = User.find_by_login_id(login_id)

    if user && user.match_password(password)
      return user
    else
      return false
    end
  end

  def match_password(password="")
    self.password == Digest::SHA1.hexdigest(password)
  end
end
