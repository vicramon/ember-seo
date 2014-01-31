require 'static_file_saver'
require 'capybara/dsl'
require 'capybara/poltergeist'

class SiteCrawler
  include ::Capybara::DSL

  attr_accessor :start_paths, :saved_paths, :queued_paths, :current_path, :current_path_bang

  def initialize(start_paths=['/'])
    self.start_paths = start_paths
    self.saved_paths = []
    self.queued_paths= []
    capybara_setup
  end

  def start_crawl
    start_message
    crawl(@start_paths)
  end

  def crawl(paths)
    paths.each do |path|
      @current_path = path
      @current_path_bang = "#!#{@current_path}"
      if !saved_paths.include? @current_path
        visit_page
        save_page
      end
    end
    queued_paths.present? ? crawl(queued_paths) : done_message
  end

  private

  def visit_page
    puts "visiting #{current_path}..."
    visit(@current_path_bang)
    @document = Nokogiri::HTML.parse(source)
    queue_links
  end

  def save_page
    @document.css('script').remove
    StaticFileSaver.new(@current_path_bang, @document).save
    saved_paths << current_path
    queued_paths.delete(current_path)
  end

  def capybara_setup
    Capybara.current_driver = :poltergeist
    Capybara.app_host = 'http://localhost:3000/'
  end

  def queue_links
    @document.css('a').each do |link|
      path = link['href'].gsub("#!",'')
      if !queued_paths.include? path and !path.include?('mailto:')
        queued_paths << path
      end
    end
  end

  def start_message
    puts "Ember SEO Crawling...\n\n"
  end

  def done_message
    puts "\nDone crawling."
  end

end
