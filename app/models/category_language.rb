class CategoryLanguage < ActiveRecord::Base
  belongs_to :category
  belongs_to :language
  validates :title, presence: true   , length: { maximum: 50 }
end
