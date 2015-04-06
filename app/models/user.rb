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
    if user = User.where(email: auth["email"])
      user
    else
      user = User.new(email: auth.info.email, password: Devise.friendly_token[0,20], name: auth.info.name)
      user.skip_confirmation!
      user.save
    end
  end

  # Likes method
  def liked(bookmark)
    likes.where(bookmark_id: bookmark.id).first
  end
end
