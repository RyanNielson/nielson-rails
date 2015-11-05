class Admin::PostsController < ApplicationController
  before_action :require_login
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_s3_direct_post, only: [:new, :create, :edit, :update]

  def index
    @posts = Post.order(published_at: :desc).all
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

  def preview
    @html = Kramdown::Document.new(params[:markdown], input: 'GFM').to_html

    render layout: false
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def set_s3_direct_post
      @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
    end

    def post_params
      params.require(:post).permit(:title, :slug, :summary, :body_markdown, :body_html, :published_at, :user_id, :tag_list)
    end
end
