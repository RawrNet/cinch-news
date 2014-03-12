require 'cinch'
require 'ostruct'
require 'open-uri'
require 'json'
require 'cgi'
require 'cinch/toolbox'

module Cinch
  module Plugins
    class News
      include Cinch::Plugin
      
      match /news$/, method: :top_news
      
      match /news (tech|money|travel|sports|life|weather|nation|offbeat|washington|world|religion|opinion|health|nfl|mlb|nba|nhl|collegefootball|collegebasketball|highschool|motorsports|golf|soccer|olympics|horseracing|people|books|music|movies)/, method: :category_news
      
      match /s-news (.+)/, method: :search_news
      
      def top_news(m)
        data = fetch_news(m)
        return m.reply "There was a problem fetching the news." if data.empty?
        output_news(m, data)
      end
      
      def category_news(m, category)
        data = fetch_category(m, category)
        return m.reply "There was a problem fetching the news for #{category}." if data.empty?
        output_news(m, data)
      end
      
      def search_news(m, terms)
        data = fetch_search(m, terms)
        return m.reply "No news results found for #{terms}." if data == false
        output_news(m, data)
      end
      
      def fetch_news(m)
        key = config[:key]
        data = JSON.parse(open("http://api.usatoday.com/open/articles/topnews?api_key=#{key}&encoding=json&count=3").read)
        stories = data['stories']
        output = []
        stories.each{|i|
        url = i['link']
        url.gsub! /apidata./, ''
        url = Cinch::Toolbox.shorten(url)
        output.push("News: | \"%s\" | Description: %s [ #{url} ]" % [i['title'], i['description']])}
        return output
      end
      
      def fetch_category(m, category)
        key = config[:key]
        data = JSON.parse(open("http://api.usatoday.com/open/articles/topnews/#{category}?api_key=#{key}&encoding=json&count=3").read)
        stories = data['stories']
        output = []
        stories.each{|i|
        url = i['link']
        url.gsub! /apidata./, ''
        url = Cinch::Toolbox.shorten(url)
        output.push("News: | \"%s\" | Description: %s [ #{url} ]" % [i['title'], i['description']])}
        return output
      end
      
      def fetch_search(m, terms)
        key = config[:key]
        search_uri = URI.encode("http://api.usatoday.com/open/articles?tag=#{terms}&count=3&api_key=#{key}&encoding=json")
        data = JSON.parse(open("#{search_uri}").read)
        stories = data['stories']
        output = []
        stories.each{|i|
        url = i['link']
        url.gsub! /apidata./, ''
        url = Cinch::Toolbox.shorten(url)
        output.push("News: | \"%s\" | Description: %s [ #{url} ]" % [i['title'], i['description']])}
        return output
        rescue JSON::ParserError
          return false
      end
      
      def output_news(m, data)
        return if data == false
        data[0..2].each{|i| m.reply i}
      end
    end
  end
end
