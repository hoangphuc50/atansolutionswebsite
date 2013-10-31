class Language < ActiveRecord::Base
  has_many :category_languages
  has_many :article_languages
  has_many :articles, :through => :category_languages
  has_many :categories,   :through => :article_languages
end
