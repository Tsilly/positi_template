class Post < ActiveRecord::Base
  include Voteable

  belongs_to :user
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories
  
  
  validates :title, :url, :description, presence: true

  after_validation :generate_slug!
  

  def to_param
    self.slug
  end

  def generate_slug!
    the_slug = to_slug(self.title)
    post = Post.find_by slug: the_slug #check if the title/slug already exists
    count = 2
    while post && post != self #while post exists && post is not the one we're currently handling with
      the_slug = append_suffix(the_slug, count) #add suffix(count/number) to the_slug
      post = Post.find_by slug: the_slug #check again if the_slug is already taken
      count += 1 #when it's ture(the_slug is taken), count accumulates
    end
    self.slug = the_slug.downcase
  end

  def append_suffix(str, count)
    if str.split('-').last.to_i != 0 #if the last is not a string(0), but an integer, i.e. the "1" in Apple Pie 1"
      return str.split('-').slice(0...-1).join('-') + "-" + count.to_s #remove the last string of "str.split('-'). And then join all the strings with '-', and add an count(number) at last.
    else
      return str + "-" + count.to_s
    end
  end

  def to_slug(name)
    str = name.strip #remove all the whitespace leading and trailing the string
    str.gsub! /\s*[^A-Za-z0-9]\s*/, "-" # replace all symbols and numbers with "-"
    str.gsub! /-+/, "-" #replace multiple "-", with only 1 "-"
    str.downcase
  end

end

