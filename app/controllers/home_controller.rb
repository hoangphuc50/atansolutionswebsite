class HomeController < ActionController::Base
  before_filter :check_language
  def check_language
    if session[:language]==nil
      @language_id=Language.where(default='true').first().id
    else
      @language_id=1
    end
  end
  def index
    category_index=Category.where("name='index'").first().id
    category_services=Category.where("name='services'").first().id
    @slide=select_html_article(category_index,1)
    @about_us_slide=select_html_article(category_index,2)
    @comment_slide= select_html_article(category_index,3)
    #@services=ArticleLanguage.includes(:article,:language).where("language_id=#{@language_id} and articles.category_id=#{category_services} and articles.priority=1").take(3).content
  end
  def projects
    category_projects=Category.where("name='projects'").first().id
    @child_projects_category=CategoryLanguage.includes(:category).where("language_id=#{@language_id} and categories.parent_id=#{category_projects}")
    if params[:id]!=nil
      @projects_list=ArticleLanguage.includes({article: :category},:language).where("language_id=#{@language_id} and articles.category_id=#{params[:id]}").all
    else
      @projects_list=ArticleLanguage.includes({article: :category},:language).where("language_id=#{@language_id} and categories.parent_id=#{category_projects}").all
    end


    #@projects_list_display=@projects_list.paginate(:page => params[:page])
  end
  def project
    @project_detail=ArticleLanguage.includes(:article,:language).where("language_id=#{@language_id} and id=#{params[:id]}").first()
    category_id=Article.where("id=#{@project_detail.article_id}").first().category_id
    @project_same_category=ArticleLanguage.includes(:article,:language).where("language_id=#{@language_id} and articles.category_id=#{category_id} and articles.id!=#{@project_detail.article_id}").take(4)
  end
  def services
    category_services=Category.where("name='services'").first().id
    @about_my_services=select_html_article(category_services,99)
    @all_services=ArticleLanguage.includes(:article,:language).where("language_id=#{@language_id} and articles.category_id=#{category_services} and articles.priority=1").all
    @slide_page_services=select_html_article(category_services,100)
  end
  def news
    news_category_id=Category.where("name='news'").first().id
    @news_category_all=CategoryLanguage.includes(:category).where("language_id=#{@language_id} and categories.parent_id=#{news_category_id}")
    if params[:id]!=nil
      @news_list_all= ArticleLanguage.includes({article: :category},:language).where("language_id=#{@language_id} and articles.category_id=#{params[:id]}").all
    else
      @news_list_all= ArticleLanguage.includes({article: :category},:language).where("language_id=#{@language_id} and categories.parent_id=#{news_category_id}").all
    end
  end
  def article
    news_category_id=Category.where("name='news'").first().id
    @article_detail=ArticleLanguage.includes(:article,:language).where("language_id=#{@language_id} and id=#{params[:id]}").first()
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
      ArticleLanguage.includes(:article,:language).where("language_id=#{@language_id} and articles.category_id=#{category_id} and articles.priority=#{priority}").first().content
  end

end