class BookComment < ApplicationRecord
  belongs_to :book
  belongs_to :user
  # bookと紐付いているからと言って、userと紐づいているわけではない！

  validates :body, presence: true
end
