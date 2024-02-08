class Post < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :retweets
  
  has_rich_text :body
  delegate :username, to: :user, prefix: true
end
