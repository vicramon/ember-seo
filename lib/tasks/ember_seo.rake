namespace :ember_seo do

  desc "Take a static snapshot of your site"
  task scrape: :environment do
    SiteCrawler.new(Rails.config.ember_seo_starting_paths).start_crawl
  end

end
