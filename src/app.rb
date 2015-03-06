require_relative 'controller'

class App
  def start
    Controller.new.start
  end
end

App.new.start


