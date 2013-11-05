class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :name
      t.boolean :enable
      t.boolean :default
      t.string :language_code
      t.string :description

      t.timestamps
    end
  end
end
