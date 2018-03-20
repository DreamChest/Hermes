class CreateContents < ActiveRecord::Migration[5.1]
  def change
    create_table :contents do |t|
      t.integer :article_id
      t.text :html

      t.timestamps
    end
  end
end
