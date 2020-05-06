
require "tty-prompt"

prompt = TTY::Prompt.new

class CLI < ActiveRecord::Base
    def self.greet
        puts "Welcome to DEVS, the tool that matches you with a developer to bring your App to life!".colorize(:blue)
        puts " "
    end


    def self.goodbye
        puts "Thanks for using DEV, see you soon!"
    end
    
end