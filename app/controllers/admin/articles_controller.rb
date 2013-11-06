class Admin::ArticlesController < Admin::ApplicationController
  before_action :signed_in_user
  layout 'admin'

  def index
    unless params[:id_cate].blank?
      #@articles = Article.include(:category).where('category_id = ?',params[:id_cate]).all
      @articles=Article.includes(:category).where("categories.parent_id=#{params[:id_cate]} or category_id=#{params[:id_cate]}")
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @articles }
      end
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @article = Article.find(params[:id])

  end

  # GET /categories/new
  def new
    @article = Article.new
    #@category_language=CategoryLanguage.new
  end

  # GET /categories/1/edit
  def edit
    @article = Article.find(params[:id])
    #@category_language=CategoryLanguage.find(params[:id],params[:language_id])
  end

  # POST /categories
  # POST /categories.json
  def create
    if params[:article][:name].blank?
      flash[:error] = 'Please enter Name !'
      redirect_to new_admin_article_path(:id_cate => params[:article][:category_id])
    elsif params[:article][:images].blank? == false && ['image/png','image/gif','image/jpeg','image/jpg'].include?(MIME::Types.type_for(params[:article][:images].original_filename).first) == false
      flash[:error] = 'Must be a url for gif, jpg, or png image. !'
      redirect_to new_admin_article_path(:id_cate => params[:article][:category_id])
    else
      @article = Article.new(article_params)
      uploaded_io = ""
      @article.images = uploaded_io
      unless params[:article][:images].blank?
        uploaded_io = params[:article][:images]
        DataFile.save(uploaded_io)
        @article.images = uploaded_io.original_filename
      end

      @article.user_id = current_user.id
      if @article.save
        flash[:notice] = I18n.t('admin.articles.new.success', :name => @article.name)
        redirect_to admin_articles_path(:id_cate => params[:id_cate])
        #redirect_to :action => :index, :id_cate=> params[:id_cate]
      else
        render :action => :new,:id_cate=> params[:id_cate]
      end
    end

  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    if params[:article][:name].blank?
      flash[:error] = 'Please enter Name !'
      redirect_to edit_admin_article_path(:id_cate => params[:article][:category_id], :id=>params[:id])
    elsif params[:article][:images].blank? == false && ['image/png','image/gif','image/jpeg','image/jpg'].include?(MIME::Types.type_for(params[:article][:images].original_filename).first) == false
      flash[:error] = 'Must be a url for gif, jpg, or png image. !'
      redirect_to edit_admin_article_path(:id_cate => params[:article][:category_id], :id=>params[:id])
    else
      @article = Article.find(params[:id])
      unless params[:article][:images].blank?
        uploaded_io = params[:article][:images]
        DataFile.save(uploaded_io)
        @article.images = uploaded_io.original_filename
      end
      @article.user_id = current_user.id
      @article.name = params[:article][:name]
      @article.category_id = params[:article][:category_id]
      @article.enable = params[:article][:enable]
      if @article.update_attributes(:id => params[:id])
        flash[:notice] = I18n.t('admin.articles.edit.success', :name => @article.name)
        redirect_to admin_articles_path(:id_cate => @article.category_id)
      else
        render :action => :edit,:id_cate=> params[:id_cate]
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @article = Article.find(params[:id])
    if @article.destroy
      flash[:notice] = I18n.t('admin.articles.destroy.success', :name => @article.name)
    else
      flash[:notice] = I18n.t('admin.articles.destroy.failure', :name => @article.name)
    end

    redirect_to admin_articles_path(:id_cate => @article.category.id)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
    #@category_language=CategoryLanguage.where(:language_id=>params[:language_id],:category_id=>params[:category_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def article_params
    params.require(:article).permit(:name, :category_id, :images, :enable)
  end
end
