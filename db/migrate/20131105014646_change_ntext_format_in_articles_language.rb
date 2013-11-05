class ChangeNtextFormatInArticlesLanguage < ActiveRecord::Migration

  def change
    change_column :article_languages, :content, :string
  end
end
