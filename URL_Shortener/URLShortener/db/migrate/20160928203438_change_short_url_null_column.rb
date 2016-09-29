class ChangeShortUrlNullColumn < ActiveRecord::Migration
  def change
    change_column_null :shortened_urls, :short_url, true
  end
end
