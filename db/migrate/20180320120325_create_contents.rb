class CreateContents < ActiveRecord::Migration[5.1]
  def change
    create_table :contents do |t|
      t.belongs_to :article
      t.text :html

      t.timestamps
    end
  end
end
