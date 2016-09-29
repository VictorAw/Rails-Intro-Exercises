class RemoveUrlIdFromTagTopics < ActiveRecord::Migration
  def change
    remove_column(:tag_topics, :url_id)
  end
end
