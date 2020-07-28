class Tweet < ApplicationRecord
    validates :body, presence: true
    belongs_to :user
    has_many :favorites


    def favorited_by?(user)
        favorites.where(user_id: user.id).exists?
    end
end
