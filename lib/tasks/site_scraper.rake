namespace :emberseo do
  task scrape: :environment do
    SiteCrawler.new(Rails.config.ember_seo_starting_paths).start_crawl
  end
end
