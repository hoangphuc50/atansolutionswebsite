class Admin::CategoryLanguagesController < Admin::ApplicationController
  before_action :signed_in_user
  before_action :set_category_language, only: [:show, :edit, :update, :destroy]

  # GET /category_languages
  # GET /category_languages.json
  def index
    @category_language = CategoryLanguage.order('id').all
  end

  # GET /category_languages/1
  # GET /category_languages/1.json
  def show
  end

  # GET /category_languages/new
  def new
    @category_language = CategoryLanguage.new
  end

  # GET /category_languages/1/edit
  def edit
  end

  # POST /category_languages
  # POST /category_languages.json
  def create
    @category_language = CategoryLanguage.new(category_language_params)
    if @category_language.save
      #flash[:notice] = @category_language.errors.full_messages
      redirect_to admin_category_path(:id=>@category_language.category.id)
    else
      render :action => :new
    end
  end

  # PATCH/PUT /category_languages/1
  # PATCH/PUT /category_languages/1.json
  def update
    if @category_language.update(category_language_params)
      #flash[:notice] = @category_language.errors.full_messages
      redirect_to admin_category_path(:id=>@category_language.category.id)
    else
      #flash[:error] = I18n.t('admin.rental_units.edit.failure')
      render :action => :edit
    end
  end

  # DELETE /category_languages/1
  # DELETE /category_languages/1.json
  def destroy
    if @category_language.destroy
      #flash[:notice] =@category_language.errors.full_messages
    else
      flash[:notice] = @category_language.errors.full_messages
    end
    if @category_language.category !=''
      redirect_to admin_category_path(:id=>@category_language.category.id)
    else
      render :action => :index
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_category_language
    @category_language = CategoryLanguage.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def category_language_params
    params.require(:category_language).permit(:category_id, :language_id, :title)
  end
end
