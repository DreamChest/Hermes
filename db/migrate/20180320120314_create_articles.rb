class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.integer :source_id
      t.string :title
      t.date :date
      t.string :url
      t.boolean :favorite, default: false
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
