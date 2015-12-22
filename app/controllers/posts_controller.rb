class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :publish, :destroy]
  before_action :check_owner, only: [:edit, :update, :destroy]


  # GET /posts
  def index
    @posts = Post.reverse_order(:desc).published.all
  end

  def unpublished
    @posts = Post.reverse_order(:desc).unpublished.all
    render :index
  end
  # GET /posts/1n
  def publish
    @post.published = true
    if post.save
      redirect_to unpublished_posts_path
    else
      render :edit
    end

    def unpublish
      @post.published = false
      if @post.save
        redirect_to unpublished_posts_path
      else
        render :edit
      end
    end
  end

  def show
    @comment = Comment.new
  end

  # GET /posts/new
  def new
    @post = Post.new
  end
  #Проверка пользователя на авторство
  def check_owner
    unless
      current_user.author_of?(@post) || current_user.admin?
      redirect_to posts_path, alert: 'У Вас нет прав на данное действие'
    end
  end
  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Пост успешно создан.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /posts/1
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Пост отредактирован.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Пост удален.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :published, category_ids: [])
    end
end
