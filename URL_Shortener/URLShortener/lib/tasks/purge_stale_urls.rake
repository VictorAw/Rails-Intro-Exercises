namespace :purge_stale_urls do
  desc "Purge stale urls from the shortened urls table"
  task purge_stale_urls: :environment do
    puts "PURGING STALE URLS!!!!"
    ShortenedUrl.purge
  end
end
