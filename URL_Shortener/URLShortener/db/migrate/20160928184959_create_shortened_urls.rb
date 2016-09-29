class CreateShortenedUrls < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|
      t.text :short_url, null: false
      t.text :long_url, null: false
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :shortened_urls, [:short_url, :long_url], unique: true
  end
end
