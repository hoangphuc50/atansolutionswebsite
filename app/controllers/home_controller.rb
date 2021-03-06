class HomeController < ActionController::Base
  before_filter :check_language
  def check_language
    session[:language]= Language.where(:language_code=>params[:lang]).first().id if !params[:lang].nil?
    session[:locale]= params[:lang] if !params[:lang].nil?
    I18n.locale = session[:locale]
    if session[:language]==nil
      @language_id=Language.where(default='true').first().id
      session[:language]=@language_id
    else
      @language_id=session[:language]
    end
    I18n.locale = Language.where(:id=>session[:language]).first().language_code
  end
  def index
    category_index=Category.where("name='index'").first().id
    category_services=Category.where("name='services'").first().id
    category_news=Category.where("name='news'").first().id
    category_projects=Category.where("name='projects'").first().id
    @slide=select_html_article(category_index,1)
    @about_us_slide=select_html_article(category_index,2)
    @comment_slide= select_html_article(category_index,3)
    @top_3_services=ArticleLanguage.includes({article: :category},:language).where("language_id=#{@language_id} and category_id=#{category_services} and articles.priority=1 and articles.enable=true").order(:created_at => :desc).order('articles.priority ASC').take(3)
    @top_5_article=ArticleLanguage.includes({article: :category},:language).where("language_id=#{@language_id} and categories.parent_id=#{category_news} and articles.enable=true").order(:created_at => :desc).take(5)
    @top_4_projects=ArticleLanguage.includes({article: :category},:language).where("language_id=#{@language_id} and categories.parent_id=#{category_projects} and articles.enable=true").order(:created_at => :desc).take(4)
    #@services=ArticleLanguage.includes(:article,:language).where("language_id=#{@language_id} and articles.category_id=#{category_services} and articles.priority=1").take(3).content
  end
  def projects
    category_projects=Category.where("name='projects'").first().id
    @child_projects_category=CategoryLanguage.includes(:category).where("language_id=#{@language_id} and categories.parent_id=#{category_projects}")
    if params[:id]!=nil
      @project_category_title=CategoryLanguage.where("language_id=#{@language_id} and category_id=#{params[:id]}").first
      @projects_list=ArticleLanguage.includes({article: :category},:language).where("language_id=#{@language_id} and articles.category_id=#{params[:id]} and articles.enable=true").order('article_languages.created_at DESC')
    else
      @projects_list=ArticleLanguage.includes({article: :category},:language).where("language_id=#{@language_id} and categories.parent_id=#{category_projects} and articles.enable=true or articles.category_id=#{category_projects} and language_id=#{@language_id} and articles.enable=true").order('article_languages.created_at DESC')
    end
    page_size=9
    if params[:page]==nil
      page=1
    else
      page=params[:page]
    end
    if @projects_list.count % page_size==0
      @total_page= Array.new(@projects_list.count / page_size)
    else
      @total_page= Array.new(@projects_list.count / page_size +1)
    end
    offset=(page.to_i*page_size.to_i)- page_size.to_i
    @projects_list=@projects_list.limit(page_size).offset(offset)
    #@projects_list_display=@projects_list.paginate(:page => params[:page])
  end
  def project
    @project_detail=ArticleLanguage.includes(:article,:language).where("language_id=#{@language_id} and article_languages.id=#{params[:id]} and articles.enable=true").first()
    category_id=Article.where("id=#{@project_detail.article_id}").first().category_id
    @project_same_category=ArticleLanguage.includes(:article,:language).where("language_id=#{@language_id} and articles.category_id=#{category_id} and articles.id!=#{@project_detail.article_id} and articles.enable=true").take(4)
  end
  def services
    category_services=Category.where("name='services'").first().id
    @about_my_services=select_html_article(category_services,99)
    @all_services=ArticleLanguage.includes(:article,:language).where("language_id=#{@language_id} and articles.category_id=#{category_services} and articles.priority NOT IN (?) and articles.enable=true",[99,100]).order('articles.priority ASC').all
    @slide_page_services=select_html_article(category_services,100)
  end
  def service
    service_category_id=Category.where("name='services'").first().id
    @service_detail=ArticleLanguage.includes(:article,:language).where("language_id=#{@language_id} and article_languages.id=#{params[:id]} and articles.enable=true").first()
    @news_category_all=CategoryLanguage.includes(:category).where("language_id=#{@language_id} and categories.parent_id=#{service_category_id}")
  end
  def news
    news_category_id=Category.where("name='news'").first().id
    @news_category_all=CategoryLanguage.includes(:category).where("language_id=#{@language_id} and categories.parent_id=#{news_category_id}")

    if params[:id]!=nil
      @news_category=CategoryLanguage.where("language_id=#{@language_id} and category_id=#{params[:id]}").first
      @news_list_all= ArticleLanguage.includes({article: :category},:language).where("language_id=#{@language_id} and articles.category_id=#{params[:id]} and articles.enable=true").order('article_languages.created_at DESC').all
    else
      @news_list_all= ArticleLanguage.includes({article: :category},:language).where("language_id=#{@language_id} and categories.parent_id=#{news_category_id} and articles.enable=true or articles.category_id=#{news_category_id} and language_id=#{@language_id} and articles.enable=true").order('article_languages.created_at DESC')
    end
  end
  def article
    news_category_id=Category.where("name='news'").first().id
    @article_detail=ArticleLanguage.includes(:article,:language).where("language_id=#{@language_id} and article_languages.id=#{params[:id]} and articles.enable=true").first()
    @news_category_all=CategoryLanguage.includes(:category).where("language_id=#{@language_id} and categories.parent_id=#{news_category_id}")
  end
  def about_us
    category_about_us=Category.where("name='about_us'").first().id
    @about_us_article=select_html_article(category_about_us,1)
    @about_us_article_slide=select_html_article(category_about_us,2)
    @about_us_article_member=select_html_article(category_about_us,3)
    @about_us_product_slide=select_html_article(category_about_us,4)
  end
  def contact
  end
  def select_html_article(category_id="",priority="")
      ArticleLanguage.includes(:article,:language).where("language_id=#{@language_id} and articles.category_id=#{category_id} and articles.priority=#{priority} and articles.enable=true").first().content
  end

end