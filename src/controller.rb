require_relative 'UI'
require_relative 'Search'
require_relative 'constants'

class Controller
  def start
    @ui_obj = UI.new
    @ui_obj.start
    @strings = Strings.new
    search_str = "Yuva"
    puts "Searching for songs of movie #{search_str}..."

    search = Searcher.instance
    results = search.do_search(search_str,Constants.instance.types[:song])

    option = 0
    while option <=0  || option > results.count do
      @ui_obj.show_options(@strings.select_options,results)
      option = gets.to_i
    end



    download_factory = DownloadFactory.instance
    downloader = download_factory.get_downloader(Constants.instance.types['song'])
    # downloader.download()
  end
end