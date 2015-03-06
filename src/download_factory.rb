require 'singleton'

class DownloadFactory
  include Singleton

  def initialize
      @downloaders = {}
  end

  def get_downloader(type)

  end




end