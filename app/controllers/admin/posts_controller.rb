class Admin::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to admin_posts_url, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def update
    post_params.inspect
    if @post.update(post_params)
      redirect_to admin_posts_url, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy

    redirect_to admin_posts_url, notice: 'Post was successfully destroyed.'
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :slug, :summary, :body_markdown, :body_html, :published_at, :user_id)
    end
end
