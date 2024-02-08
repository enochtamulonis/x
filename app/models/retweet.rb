class Retweet < ApplicationRecord
  belongs_to :post
  belongs_to :user
end
