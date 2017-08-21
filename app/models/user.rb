class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name, :first_name, :last_name, :status, :image
  validates :name, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, confirmation: true
  has_many :posts, dependent: :destroy
  validates_format_of :first_name, :last_name, { :with => /^[a-z]+$/i, :message => "Can only contain letters" }
  validates_format_of :name, { :with => /^[a-zA-Z]+[0-9]*$/i, :message => "Should contain letters" }
  validates_format_of :password, { :with => /^[a-z]+[A-Z]+[0-9]+[#!]+/i, :message => "Should contain atleast one small, capital, digit and a special character(!, #)"}
  has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "400x200" }
end
