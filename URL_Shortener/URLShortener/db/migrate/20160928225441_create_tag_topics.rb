class CreateTagTopics < ActiveRecord::Migration
  def change
    create_table :tag_topics do |t|
      t.text :topic, null: false
      t.integer :url_id, null: false
    end
  end
end
