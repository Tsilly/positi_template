class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes, as: :voteable
  
  has_secure_password validations: false

  validates :username, uniqueness: true
  validates :password, length: { in: 6..20 }, on: :create
  validates :time_zone, presence: true

  after_validation :generate_slug!

  def generate_slug!
    the_slug = to_slug(self.username)
    user = User.find_by slug: the_slug
    count = 2
    while user && user != self
      the_slug = append_suffix(the_slug, count)
      user = user.find_by slug: the_slug
      count += 1
    end
    self.slug = the_slug.downcase
  end

  def append_suffix(str, count)
    if str.split('-').last.to_i != 0
      return str.split('-').slice(0...-1).join('-') + "-" + count.to_s
    else
      return str + "-" + count.to_s
    end
  end

  def to_slug(name)
    str = name.strip
    str.gsub! /\s*[^A-Za-z0-9]\s*/, "-"
    str.gsub! /-+/, "-"
    str.downcase
  end
end
