class ArticleLanguage < ActiveRecord::Base
  belongs_to :article
  belongs_to :language
end
