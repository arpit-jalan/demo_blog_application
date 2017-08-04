class Post < ActiveRecord::Base
  belongs_to :user
  validates :title, presence: true, length: {minimum: 20}
  validates :body, presence: true, length: {minimum: 20}
  attr_accessible :String, :body, :title, :user_id
end
