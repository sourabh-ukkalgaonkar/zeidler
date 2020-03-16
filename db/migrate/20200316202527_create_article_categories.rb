class CreateArticleCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :article_categories do |t|
      t.references :article
      t.references :category

      t.timestamps
    end
  end
end
