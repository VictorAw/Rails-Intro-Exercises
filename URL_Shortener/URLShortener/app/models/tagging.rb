class Tagging < ActiveRecord::Base
  belongs_to :topic,
    class_name: :TagTopic,
    primary_key: :id,
    foreign_key: :topic_id

  belongs_to :url,
    class_name: :ShortenedUrl,
    primary_key: :id,
    foreign_key: :url_id

end
