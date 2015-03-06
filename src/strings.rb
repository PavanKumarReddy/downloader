#TODO change to module instead of class

class Strings
  def initialize
    @welcome_message = "Welcome to Downloader"
    @select_options = "Enter option to select"
  end

  def welcome_message
    @welcome_message
  end

  def select_options
    @select_options
  end

  def user_options
    options = {:song => "Enter the movie name to download songs:"}
  end

end

