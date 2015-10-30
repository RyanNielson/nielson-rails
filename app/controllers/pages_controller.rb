class PagesController < ApplicationController
  def home
  	@posts = Post.published.order(published_at: :desc).all
  end
end
