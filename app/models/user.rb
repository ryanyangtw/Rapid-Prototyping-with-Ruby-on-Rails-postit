class User < ActiveRecord::Base
  include Sluggable

  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length:{minimum: 3}
  #on: :create => only fire on create and not fire when update, 
  #因為我們希望使用者在修改帳號資料時不需要重新輸入密碼

  #在update user 時，若password column沒有輸入字串或是輸入空白字串，password不會被跟新

  #before_save :generate_slug!
  sluggable_column :username


  def admin?
    self.role == "admin"
  end

  def moderator?
    self.role == "moderator"
  end

  def two_factor_auth?
    !self.phone.blank?
  end

  def generate_pin!
    self.update_column(:pin, rand(10**6) )
  end

  def remove_pin!
    self.update_column(:pin, nil)
  end

  def send_pin_to_twilio
    # put your own credentials here 
    
    account_sid = 'ACcb891537ca62cfb78cca217054630f1c'
    auth_token = 'b93a8add308fcfeac4a6ca8ecf940410' 
     
    # set up a client to talk to the Twilio REST API 
    client = Twilio::REST::Client.new account_sid, auth_token 
    msg = "Hi, please input the pin to continue login: #{self.pin}" 

    client.account.messages.create({
      :from => '+12766334591', 
      #:to => '+886988235030', 
      :to => self.phone,
      :body => msg,  
    })
  end

=begin
  def to_param
    self.slug
  end

  def generate_slug!
    the_slug = to_slug(self.username)
    user = User.find_by slug: the_slug
    count = 2
    while user && user != self
      the_slug = append_suffix(the_slug, count)
      user = User.find_by slug: the_slug
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