task scrape: :environment do
  SiteCrawler.new(['/starting/path/1', '/starting/path/2']).start_crawl
end
