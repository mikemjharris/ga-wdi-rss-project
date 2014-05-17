class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :author
      t.text :summary
      t.text :content
      t.text :category
      t.datetime :published
      t.string :image
      t.string :guid
      t.string :url

      t.timestamps
    end
  end
end
