class Category < ActiveRecord::Base
  has_many :category_languages
  has_many :articles
  has_many :children, class_name: 'Category',
           foreign_key: 'parent_id'

  belongs_to :parent, class_name: 'Category'
  has_many :languages,:through => :category_languages
end
