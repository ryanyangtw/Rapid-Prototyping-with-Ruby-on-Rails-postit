class Post < ActiveRecord::Base
  include Voteable
  include Sluggable

  belongs_to :creator, class_name: 'User', foreign_key: 'user_id' 
  has_many :comments

  has_many :post_categories
  has_many :categories, through: :post_categories

  # Move code to Concern (config.root/lib/voteable.rb) 
  #has_many :votes, as: :voteable


  validates :title, presence: true, length: {minimum: 5}
  validates :description, presence: true
  validates :url, presence: true, uniqueness: true

  sluggable_column :title

  # Move code to Concern (config.root/lib/sluggable.rb) 
  #before_save :generate_slug!

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

# Move code to Concern (config.root/lib/sluggable.rb) 
=begin

  def to_param
    self.slug
  end

  def generate_slug!
    the_slug = to_slug(self.title)
    post = Post.find_by slug: the_slug
    count = 2
    while post && post != self
      the_slug = append_suffix(the_slug, count)
      post = Post.find_by slug: the_slug
      count += 1
    end
    self.slug = the_slug
  end

  def append_suffix(str, count)
    if str.split('-').last.to_i != 0
      return str.split('-').slice(0...-1).join('-') + '-' + count.to_s
    else
      return str + '-' + count.to_s
    end
  end

  def to_slug(title)
    str = title.strip
    str.gsub! /\s*[^A-Za-z0-9]\s*/, '-'
    str.gsub! /-+/, "-"
    str.downcase
  end
=end


end