require 'singleton'
require_relative 'constants'
require_relative 'songs_ap_parser'

class Searcher
  include Singleton

  def initialize
     register_parsers
  end

  def register_parsers
    constants = Constants.instance
    @parsers = {constants.types[:song].to_sym => [SongsApParser.new]}
  end

  def do_search(name,type)
    puts "fetching parser for type #{type} and #{name}"

    #TODO handle parsings from multiple sites

    parser = @parsers[type.to_sym][0]
    names = parser.get_names(name)
    return names
  end

end
