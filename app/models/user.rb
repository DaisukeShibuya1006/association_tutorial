class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  
  has_many :tweets
  has_many :favorites
  has_many :favorite_tweets, through: :favorites, source: :tweet
  
  
  has_many :active_relationships, class_name: "Relationship", foreign_key: :following_id
  has_many :followings, through: :active_relationships, source: :follower

  has_many :passive_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :following

  def followed_by?(user)
    passive_relationships.find_by(following_id: user.id).present?
  end

  def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.name = auth.name
        user.email = User.dummy_email(auth)
        user.image = auth.info.image
        user.password = Devise.friendly_token[0,20]
      end
  end

  private
    def self.dummy_email(auth)
        "#{auth.uid}-#{auth.provider}@example.com"
    end
end
