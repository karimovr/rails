class ProfileController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]


    def index
      @profiles = Profile.all
    end


    def show
      @profile = Profile.new
    end
  def create
    @profile = Profile.find(params[:@profile_id])
    @comment = Comment.new(comment_params)
    @comment.post = @post
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @profile, notice: 'Профиль создан.' }
      else
        format.html { render :new }
      end
    end
    def edit
    end


    def create
      @profile = Profile.new(profile_params)

      respond_to do |format|
        if @profile.save
          format.html { redirect_to @profile, notice: 'Профиль успешно создан.' }
        else
          format.html { render :new }
        end
      end
    end


    def update
      respond_to do |format|
        if @profile.update(profile_params)
          format.html { redirect_to @profile, notice: 'Профиль отредактирован.' }
        else
          format.html { render :edit }
        end
      end
    end


    def destroy
      @profile.destroy
      respond_to do |format|
        format.html { redirect_to profiles_url, notice: 'Профиль удален.' }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:profile).permit(:title, :body, category_ids: [])
    end
  end

end
