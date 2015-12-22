class Admin::CategoriesController < Admin::BaseController
  before_action :set_category, only: [:show, :edit, :update, :destroy]


      # GET /categories
    def index
      @categories = Category.all
    end

    # GET /categories/1
    def show
      @category = Category.find(params[:id])
      @posts = @category.posts
    end


    # GET /categories/new
    def new
      @category = Category.new
    end

    # GET /categories/1/edit
    def edit
    end

    # POST /categories
    def create
      @category = Category.new(category_params)

      respond_to do |format|
        if @category.save
          format.html { redirect_to @category, notice: 'Категория создана.' }

        else
          format.html { render :new }
        end
      end
    end

    # PATCH/PUT /categories/1
    def update
      respond_to do |format|
        if @category.update(category_params)
          format.html { redirect_to edit_admin_category_path, notice: 'Категория отредактирована.' }
        else
          format.html { render :edit }
        end
      end
    end

    # DELETE /categories/1
    def destroy
      @category.destroy
      respond_to do |format|
        format.html { redirect_to categories_url, notice: 'Категория удалена.' }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:title)
    end
  end
