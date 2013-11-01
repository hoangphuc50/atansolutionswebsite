class Language < ActiveRecord::Base
  has_many :category_languages
  has_many :article_languages
  validates :name, presence: true   , length: { maximum: 50 }
  validates :language_code, presence: true   , length: { maximum: 3 }
end
