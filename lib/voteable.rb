module Voteable
  extend ActiveSupport::Concern
  
  included do
    has_many :votes, as: :voteable #polymorphic
  end
  def total_votes
    self.up_votes - self.down_votes
  end

  def up_votes
    self.votes.where(vote: true).size
  end

  def down_votes
    self.votes.where(vote: false).size 
  end
end

#Using normal metaprogramming
=begin
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.extend ClassMethods
    base.class_eval do
      my_calss_method
    end
  end


  module InstanceMethods
    def total_votes
      self.up_votes - self.down_votes
    end

    def up_votes
      self.votes.where(vote: true).size
    end

    def down_votes
      self.votes.where(vote: false).size 
    end
  end

  module ClassMethods
    def my_calss_method
      has_many :votes, as: :voteable #polymorphic
    end
  end
end
=end