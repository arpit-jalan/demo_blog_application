class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name, :first_name, :last_name
  validates :name, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  # validates :email, presence: true, uniqueness: true
  validates :password, confirmation: true
  has_many :posts
end
