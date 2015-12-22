class CommentsController < ApplicationController
  before_action :authenticate_user!, exept: [:index, :show]
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :check_owner, only: [:edit, :update, :destroy]
  # GET /comments
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  #Проверка авторства пользователя
  def check_owner
    unless
    @comment_user == current_user || current_user.admin?
      redirect_to post_url, alert: 'У Вас нет прав на данное действие'
    end
  end
  # GET /posts/1/edit
  def edit
  end
  # POST /comments
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment_user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, notice: 'Комментарий успешно создан.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /comments/1
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @comment.post, notice: 'Comment was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
      @post = @comment.post
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body)
    end
end
