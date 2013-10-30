class Language < ActiveRecord::Base
  has_many :category_languages
  has_many :article_languages
end
