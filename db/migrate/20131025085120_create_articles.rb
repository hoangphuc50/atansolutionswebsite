class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :category_id
      t.integer :user_id
      t.string :images
      t.integer :priority
      t.boolean :enable

      t.timestamps
    end
  end
end
