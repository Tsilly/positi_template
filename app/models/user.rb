class User < ActiveRecord::Base
	has_many :posts
	has_many :comments
	has_secure_password validations: false

	validates :username, uniqueness: true
	validates :password, length: { in: 6..20 }, on: :create
	validates :time_zone, presence: true
end
