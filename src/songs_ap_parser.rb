require 'nokogiri'
require 'open-uri'

class SongsApParser
  def initialize

  end

  def get_names(name)
    names = []

    page = Nokogiri::HTML(open("http://songsap.in/music/list/3340397"))
    list = page.css("div[class=f1]")
    list.each do |elem|
      begin
        title = elem.css('a')[0].text
        if title.downcase.include? name.downcase
          names << decorate_name(title)
        end
      rescue Exception => e
        puts "thrown exception for #{elem}"
        puts e
      end
    end
    names
  end

  def decorate_name(title)
    "#{title} songsap.in"
  end

end