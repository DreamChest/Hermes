class CreateSources < ActiveRecord::Migration[5.1]
  def change
    create_table :sources do |t|
      t.belongs_to :user
      t.string :name
      t.string :url
      t.string :favicon_url
      t.string :favicon_path
      t.datetime :last_update, default: Time.at(0).utc

      t.timestamps
    end
  end
end
