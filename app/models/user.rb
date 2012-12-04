class User < ActiveRecord::Base
  attr_accessible :name, :address, :email, :phone, :join_date, :roll, :login_id, :password

  has_many :requestors
  has_many :administrators
  has_many :sw_developers
  has_many :evaluators


end
