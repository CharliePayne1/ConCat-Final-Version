
require "tty-prompt"

prompt = TTY::Prompt.new
spinner = TTY::Spinner.new

class CLI < ActiveRecord::Base
    def self.loading_bar
        spinner = TTY::Spinner.new("[:spinner] Loading ...", format: :pulse_2)
        spinner.auto_spin 
        sleep(2)
        spinner.stop("We're good to go!")
        puts " "
    end
    
    def self.greet
        a = Artii::Base.new :font => 'bulbhead'
        puts a.asciify('ConCat').blue
        puts " "
        puts "Welcome to ConCat, the tool that matches you with a developer to bring your App to life!".colorize(:blue)
        puts " "
    end

    def self.goodbye
        puts " "
        puts " "
        puts "Thanks for using ConCat, hopefully see you soon!".colorize(:blue)
    end
    
end