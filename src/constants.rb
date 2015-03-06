require 'singleton'

class Constants
  include Singleton

  def initialize
    @@types ={:song => 'song'}
  end

  def types
    @@types
  end


end