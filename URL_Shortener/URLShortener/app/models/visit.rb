class Visit < ActiveRecord::Base
  def self.record_visit!(user, short_url)
    Visit.create!(user_id: user.id, url_id: short_url.id)
  end

  belongs_to :visitor,
    class_name: :User,
    primary_key: :id,
    foreign_key: :user_id

  belongs_to :visited_url,
    class_name: :ShortenedUrl,
    primary_key: :id,
    foreign_key: :url_id
end
