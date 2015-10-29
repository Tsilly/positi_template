class User < ActiveRecord::Base
  include Sluggable

  has_many :posts
  has_many :comments
  has_many :votes, as: :voteable
  
  has_secure_password validations: false

  validates :username, uniqueness: true
  validates :password, length: { in: 6..20 }, on: :create
  validates :time_zone, presence: true

  sluggable_column :username
  
end
