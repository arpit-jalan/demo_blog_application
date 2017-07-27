class Post < ActiveRecord::Base
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true
  attr_accessible :String, :body, :title, :user_id
end
