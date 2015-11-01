class Post < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true
  validates :slug, presence: true
  validates :summary, presence: true

  scope :published, -> { where('published_at < ?', DateTime.now) }

  before_save :convert_body_to_html

  private

  def convert_body_to_html
    self.body_html = Kramdown::Document.new(body_markdown, input: 'GFM').to_html
  end
end
