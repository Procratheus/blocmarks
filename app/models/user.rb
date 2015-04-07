class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_many :topics, dependent: :destroy
  has_many :likes, dependent: :destroy

  # omniauth model method
  def self.from_omniauth(auth, signed_in_resource=nil)
    data = auth.extra.raw_info
    if user = User.where(email: data["email"]).first
      return user
    else
      user = User.new(email: data.email, password: Devise.friendly_token[0,20], name: data.name)
      user.skip_confirmation!
      user.save
      return user
    end
  end

  def skip_confirmation!
    self.confirmed_at = Time.now
  end

  # Likes method
  def liked(bookmark)
    likes.where(bookmark_id: bookmark.id).first
  end
end
