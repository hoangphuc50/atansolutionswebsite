class Article < ActiveRecord::Base
  belongs_to :category
  has_many :article_languages
  belongs_to :user
end
