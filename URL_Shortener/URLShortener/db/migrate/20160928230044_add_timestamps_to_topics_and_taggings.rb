class AddTimestampsToTopicsAndTaggings < ActiveRecord::Migration
  def change
    add_column(:tag_topics, :created_at, :datetime)
    add_column(:tag_topics, :updated_at, :datetime)

    add_column(:taggings, :created_at, :datetime)
    add_column(:taggings, :updated_at, :datetime)
  end
end
