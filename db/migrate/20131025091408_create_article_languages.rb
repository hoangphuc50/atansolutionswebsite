class CreateArticleLanguages < ActiveRecord::Migration
  def change
    create_table :article_languages do |t|
      t.integer :language_id
      t.integer :article_id
      t.string :title
      t.string :short_description
      t.text :content

      t.timestamps
    end
  end
end
