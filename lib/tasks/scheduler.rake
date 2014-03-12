# this is a task for grabbing code from reddit
task scrape_reddit: :environment do
  puts "Hiya! I'm about to scrape Reddit"

  # this grabs the source code of reddit
  @raw_html = HTTParty.get("http://www.reddit.com")

  puts "lets get the raw HTML"
  # lets turn the raw html into real html we can parse
  @real_html = Nokogiri::HTML(@raw_html)

  puts "lets get the real HTML"
  puts @real_html

  @real_html.css("div#siteTable a.title").each do |link|
    # this is similar to the stories#index view
    @story = Story.new
    @story.title = link.text
    @story.link = link[:href]
    @story.save
  end
end
