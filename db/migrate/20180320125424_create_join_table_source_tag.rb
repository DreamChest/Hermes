class CreateJoinTableSourceTag < ActiveRecord::Migration[5.1]
  def change
    create_join_table :sources, :tags do |t|
      t.index %i[source_id tag_id]
      t.index %i[tag_id source_id]
    end
  end
end
