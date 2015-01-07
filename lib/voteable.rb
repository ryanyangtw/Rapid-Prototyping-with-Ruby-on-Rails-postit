# Move code to voteable_ryan gem
=begin
# Usinfg Concerns
module Voteable
  extend ActiveSupport::Concern 
  
  # When we include this module the included will be fired
  included do 
    # has_many is a class method inheriented from ActiveRecord::Base
    has_many :votes, as: :voteable
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
=end



=begin
# Using normal Metaprogramming
module Voteable
  # When we include this module the include will be fired
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.extend ClassMethods
    base.class_eval do
      my_class_method
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
    def my_class_method
      #puts "This is my Class Method"
      has_many :votes, as: :voteable
    end
  end
end
=end
