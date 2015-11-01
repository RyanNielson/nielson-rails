class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :slug, presence: true
  validates :summary, presence: true

  scope :published, -> { where('published_at < ?', DateTime.now) }

  before_save :convert_body_to_html

  has_many :taggings
  has_many :tags, through: :taggings

  def self.tagged_with(name)
    Tag.find_by(name: name).posts
  end

  def tag_list
    tags.order(name: :asc).map(&:name)
  end

  def tag_list=(names)
    self.tags = names.split.map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

  private
    def convert_body_to_html
      self.body_html = Kramdown::Document.new(body_markdown, input: 'GFM').to_html
    end
end
