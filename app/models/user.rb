class User < ActiveRecord::Base
  acts_as_voter

  has_many :services, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  accepts_nested_attributes_for :comments

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
end
