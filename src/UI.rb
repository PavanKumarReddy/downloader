require_relative 'strings.rb'

class UI

  def initialize
    @strings = Strings.new
  end

  def start
    puts @strings.welcome_message
    puts @strings.user_options[:song]
  end

  def show_options(msg,list)
    puts msg
    count = 1
    list.each do |option|
      puts "#{count}. #{option} "
      count += 1
    end
  end
end



