class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :slug, presence: true
  validates :summary, presence: true

  scope :published, -> { where('published_at < ?', DateTime.now) }

  before_save :convert_body_to_html

  acts_as_taggable

  private
    def convert_body_to_html
      self.body_html = Kramdown::Document.new(body_markdown, input: 'GFM').to_html
    end
end
