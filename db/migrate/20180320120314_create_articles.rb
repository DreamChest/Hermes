class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.belongs_to :source
      t.string :title
      t.datetime :date
      t.string :url
      t.boolean :favorite, default: false
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
