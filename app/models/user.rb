class User < ActiveRecord::Base
  attr_accessible :name, :address, :email, :phone, :join_date, :roll, :login_id, :password, :password_confirmation, :last_login

  has_one :requestor, :foreign_key => :id
  has_one :administrator, :foreign_key => :id
  has_one :sw_developer, :foreign_key => :id
  has_one :evaluator, :foreign_key => :id

  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}$/i
  validates :name, :presence => true
  validates :login_id, :presence => true, :uniqueness => true
  validates :password, :presence => true, :length => { :minimum => 3 }
  validates_confirmation_of :password
  validates :roll, :presence => true
  validates :email, :presence => true, :format => EMAIL_REGEX
  validates :address, :presence => true
  validates :phone, :presence => true

  has_many :gcm_devices, :class_name => Gcm::Device

  def encrypt_password
    if self.password.present?
      self.password = Digest::SHA1.hexdigest(self.password)
    end
    if self.password_confirmation.present?
      self.password_confirmation = Digest::SHA1.hexdigest(self.password_confirmation)
    end
  end

  def self.authenticate(login_id="", password="")
    user = User.find_by_login_id(login_id)

    if user && user.match_password(password)
      #user.last_login = Time.now
      #user.save
      return user
    else
      return false
    end
  end

  def match_password(password="")
    self.password == Digest::SHA1.hexdigest(password)
  end

  def send_message message
    self.gcm_devices.each do |gcm_device|
      notification = Gcm::Notification.new
      notification.device = gcm_device
      notification.collapse_key = "updates_available"
      notification.delay_while_idle = false
      notification.data = {:registration_ids => ["#{gcm_device.registration_id}"], :data => {:message_text => message}}
      notification.save!
    end
    Gcm::Notification.send_notifications
  end

  def self.debug_time
    #return 0
    return 1.years
  end
end
