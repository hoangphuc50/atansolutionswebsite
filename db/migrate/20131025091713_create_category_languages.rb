class CreateCategoryLanguages < ActiveRecord::Migration
  def change
    create_table :category_languages do |t|
      t.integer :category_id
      t.integer :language_id
      t.string :title

      t.timestamps
    end
  end
end
