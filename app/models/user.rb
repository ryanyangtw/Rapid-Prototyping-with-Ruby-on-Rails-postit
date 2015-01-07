class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length:{minimum: 3}
  #on: :create => only fire on create and not fire when update, 
  #因為我們希望使用者在修改帳號資料時不需要重新輸入密碼

  #在update user 時，若password column沒有輸入字串或是輸入空白字串，password不會被跟新

  before_save :generate_slug

  def generate_slug
    self.slug = self.username.gsub(' ', '-')
  end

  def to_param
    self.slug
  end

end