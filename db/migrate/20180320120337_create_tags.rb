class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.belongs_to :user
      t.string :name
      t.string :color, default: '#ffffff'

      t.timestamps
    end
  end
end
