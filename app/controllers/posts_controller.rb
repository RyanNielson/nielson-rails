class PostsController < ApplicationController
  before_action :set_post, only: [:show]

  def index
    @tag = params[:tag]
    @posts = @tag ? Post.tagged_with(@tag) : Post.all
  end

  def show
  end

  private
    def set_post
      @post =  Post.find_by(slug: params[:id])
    end
end
