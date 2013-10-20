# Contains methods for printing.
module Printer

  def self.reputs(str='')
    puts "\e[0K" + str
  end

  def self.clear_screen!
    print "\e[2J"
  end

  def self.move_to_home!
    print "\e[H"
  end

  def self.flush!
    $stdout.flush
  end

end
