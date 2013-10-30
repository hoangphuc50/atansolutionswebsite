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
    @slide=ArticleLanguage.includes(:article,:language).where("language_id=#{@language_id} and articles.category_id=#{category_index} and articles.priority=1").first().content
    @about_us_slide=ArticleLanguage.includes(:article,:language).where("language_id=#{@language_id} and articles.category_id=#{category_index} and articles.priority=2").first().content
    @comment_slide=ArticleLanguage.includes(:article,:language).where("language_id=#{@language_id} and articles.category_id=#{category_index} and articles.priority=3").first().content
    #@services=ArticleLanguage.includes(:article,:language).where("language_id=#{@language_id} and articles.category_id=#{category_services} and articles.priority=1").take(3).content
  end
  def projects

  end
  def services
    category_services=Category.where("name='services'").first().id
    @about_my_services=ArticleLanguage.includes(:article,:language).where("language_id=#{@language_id} and articles.category_id=#{category_services} and articles.priority=99").first().content
    @all_services=ArticleLanguage.includes(:article,:language).where("language_id=#{@language_id} and articles.category_id=#{category_services} and articles.priority=1").all
    @slide_page_services=ArticleLanguage.includes(:article,:language).where("language_id=#{@language_id} and articles.category_id=#{category_services} and articles.priority=100").first().content
  end
  def news
  end
  def about_us
    category_about_us=Category.where("name='about_us'").first().id
    @about_us_article=ArticleLanguage.includes(:article,:language).where("language_id=#{@language_id} and articles.category_id=#{category_about_us} and articles.priority=1").first().content
    @about_us_article_slide=ArticleLanguage.includes(:article,:language).where("language_id=#{@language_id} and articles.category_id=#{category_about_us } and articles.priority=2").first().content
    @about_us_article_member=ArticleLanguage.includes(:article,:language).where("language_id=#{@language_id} and articles.category_id=#{category_about_us} and articles.priority=3").first().content
    @about_us_product_slide=ArticleLanguage.includes(:article,:language).where("language_id=#{@language_id} and articles.category_id=#{category_about_us} and articles.priority=4").first().content
  end
  def contact
  end
end