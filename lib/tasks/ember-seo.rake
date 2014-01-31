require 'site_crawler'

namespace :ember_seo do

  desc "Take a static snapshot of your site"
  task :scrape do
    SiteCrawler.new(Rails.application.config.ember_seo_starting_paths).start_crawl
  end

end
