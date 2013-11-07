class Admin::ArticleLanguagesController < ApplicationController
  before_action :signed_in_user
  before_action :set_article_language, only: [:show, :edit, :update, :destroy]
  layout 'admin'
  # GET /article_languages
  # GET /article_languages.json
  def index
    @article_language = ArticleLanguage.order('id').all
  end

  # GET /article_languages/1
  # GET /article_languages/1.json
  def show
  end

  # GET /article_languages/new
  def new
    @article_language = ArticleLanguage.new
  end

  # GET /article_languages/1/edit
  def edit
    @article_language = ArticleLanguage.find(params[:id])
  end

  # POST /article_languages
  # POST /article_languages.json
  def create

    if params[:article_language][:title].blank?
      flash[:error] = 'Please enter Title !'
      redirect_to new_admin_article_language_path(:id => params[:id],:id_cate => params[:id_cate])
    elsif  params[:article_language][:title].length > 255
      flash[:error] = 'Title cannot than 255 characters !'
      redirect_to new_admin_article_language_path(:id => params[:id],:id_cate => params[:id_cate])

    elsif  params[:article_language][:short_description].length > 255
      flash[:error] = 'Short Description cannot than 255 characters !'
      redirect_to new_admin_article_language_path(:id => params[:id],:id_cate => params[:id_cate])
    elsif exist_language_category.count.hash == 0.hash
      flash[:error] = 'Category language do not exist. Please, choose other language !'
      redirect_to new_admin_article_language_path(:id => params[:id],:id_cate => params[:id_cate])
    elsif exist_language_article.count > 0
      flash[:error] = 'Language exist. Please, choose other language !'
      redirect_to new_admin_article_language_path(:id => params[:id],:id_cate => params[:id_cate])
    else
      @article_language = ArticleLanguage.new(article_language_params)
      if @article_language.save
        flash[:notice] = I18n.t('admin.languages.new.success', :name => @article_language.title)
        redirect_to admin_article_path(:id=>params[:id], :id_cate => params[:id_cate])

      else
        render :action => :new
      end
    end

  end

  # PATCH/PUT /article_languages/1
  # PATCH/PUT /article_languages/1.json
  def update

    if params[:article_language][:title].blank?
      flash[:error] = 'Please enter Title !'
      redirect_to edit_admin_article_language_path(:id_arti => params[:article_language][:article_id],:id_cate => @article_language.article.category_id,:id => params[:id],:action=>'edit')
    elsif  params[:article_language][:title].length > 255
      flash[:error] = 'Title cannot than 255 characters !'
      redirect_to edit_admin_article_language_path(:id_arti => params[:article_language][:article_id],:id_cate => @article_language.article.category_id,:id => params[:id],:action=>'edit')

    elsif  params[:article_language][:short_description].length > 255
      flash[:error] = 'Short Description cannot than 255 characters !'
      redirect_to edit_admin_article_language_path(:id_arti => params[:article_language][:article_id],:id_cate => @article_language.article.category_id,:id => params[:id],:action=>'edit')
    elsif exist_language_category.count.hash == 0.hash
      flash[:error] = 'Category language do not exist. Please, choose other language !'
      redirect_to edit_admin_article_language_path(:id_arti => params[:article_language][:article_id],:id_cate => @article_language.article.category_id,:id => params[:id],:action=>'edit')
    elsif exist_language_article.count > 0
      flash[:error] = 'Language exist. Please, choose other language !'
      redirect_to edit_admin_article_language_path(:id_arti => params[:article_language][:article_id],:id_cate => @article_language.article.category_id,:id => params[:id],:action=>'edit')
    else
      @article_language = ArticleLanguage.find(params[:id])
      if @article_language.update(article_language_params)
        flash[:notice] = I18n.t('admin.languages.edit.success', :name => @article_language.title)
        redirect_to admin_article_path(:id=>@article_language.article.id, :id_cate => @article_language.article.category.id)
      else
        #flash[:error] = I18n.t('admin.rental_units.edit.failure')
        render :action => :edit
      end
    end

  end

  # DELETE /article_languages/1
  # DELETE /article_languages/1.json
  def destroy
    if @article_language.destroy
      flash[:notice] = I18n.t('admin.categories.destroy.success', :name => @article_language.title)

    else
      flash[:notice] = I18n.t('admin.categories.destroy.failure', :name => @article_language.title)
    end

    redirect_to admin_article_path(:id=>@article_language.article.id, :id_cate => @article_language.article.category.id)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_article_language
    @article_language = ArticleLanguage.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def article_language_params
    params.require(:article_language).permit(:article_id, :language_id, :title, :short_description, :content)
  end

  def exist_language_article
    if @_action_name == 'update'
      ArticleLanguage.where('article_id = ? AND language_id = ? AND id <> ?',
                            params[:article_language][:article_id], params[:article_language][:language_id],
                            params[:id])
    else
      ArticleLanguage.where('article_id = ? AND language_id = ? AND id <> ?',
                            params[:article_language][:article_id], params[:article_language][:language_id],
                            0)
    end

  end

  def exist_language_category
    if @_action_name == 'update'
     CategoryLanguage.where('language_id = ? AND category_id = ?',params[:article_language][:language_id], @article_language.article.category_id)
    else
      CategoryLanguage.where('language_id = ? AND category_id = ?',params[:article_language][:language_id], params[:id_cate])
      end
  end
end
