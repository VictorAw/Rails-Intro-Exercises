class RemoveConstraintsFromShortUrl < ActiveRecord::Migration
  def change
    change_column :shortened_urls, :short_url, :text
  end
end
