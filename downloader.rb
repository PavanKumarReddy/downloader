require 'nokogiri'
require 'open-uri'

def download_songs_in_movie(url)
  page = Nokogiri::HTML(open(url))
  list = page.css("a")
  list.each do |elem|
    if elem['href'].include? "music/view"
      puts "Downloading #{elem.text}"
      song_page = Nokogiri::HTML(open("http://songsap.in#{elem['href']}"))
      all_links = song_page.css('a')
      all_links.each do |link|
        if link['href'].include? 'music/down'
          puts "got the url as #{link['href']}"
          song_download_link = link['href']
          puts song_download_link

          file_name = elem.text + ".mp3"

          puts "saving as #{file_name}"

          Net::HTTP.start("songsap.in") do |http|
            puts "original link is #{song_download_link}"
            resp = http.get(song_download_link)
            redirect_count = 0
            while resp.code == '301' || resp.code == '302'
              # moved permanently or temporarily:  try again at the new location.
              redirect_count = redirect_count + 1
              puts "trying with #{resp.header['location']} for #{redirect_count}"
              encoded_url = URI.encode(resp.header['location'])

              uri = URI.parse(encoded_url)
              Net::HTTP.start(uri.host) do |http1|
                resp = http1.get(uri.path)
              end

              puts resp.code
              # ideally you should also bail if you make too many redirects.
            end


            puts "writing to file"
            puts resp.code
            puts resp.header['location']

            open(file_name, "w") do |file|
              file.write(resp.body)
            end
          end


        end
      end
    end
  end



end

page = Nokogiri::HTML(open("http://songsap.in/music/list/3340397"))
search_title = "Bombay"
list = page.css("div[class=f1]")

list.each do |elem|
  begin
    title = elem.css('a')[0].text
    partial_href = elem.css('a')[0]["href"]
    if title.include? search_title
      puts "Downloading songs for title #{search_title}"
      url = "http://songsap.in" + partial_href
      download_songs_in_movie(url)
      break
    end
  rescue Exception => e
    puts "thrown exception for #{elem}"
    puts e
  end
end




