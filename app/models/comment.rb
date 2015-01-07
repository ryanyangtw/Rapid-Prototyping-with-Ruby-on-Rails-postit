class Comment < ActiveRecord::Base

  include Voteable
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  belongs_to :post
  # Move code to Concern (config.root/lib/voteable.rb) 
  #has_many :votes, as: :voteable

  validates :body, presence: true
  

# Move code to Concern (config.root/lib/voteable.rb) 
=begin
  def total_votes
    self.up_votes - self.down_votes
  end

  def up_votes
    self.votes.where(vote: true).size
  end
  
  def down_votes
    self.votes.where(vote: false).size
  end
=end
end