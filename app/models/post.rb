class Post < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :slug, presence: true
  validates :summary, presence: true

  scope :published, -> { where('published_at < ?', DateTime.now) }
end
