
require "tty-prompt"

prompt = TTY::Prompt.new

class CLI < ActiveRecord::Base
    def self.greet
        puts "Welcome to ConCat, the tool that matches you with a developer to bring your App to life!".colorize(:blue)
        puts " "
    end

    def self.goodbye
        puts "Thanks for using ConCat, hopefully see you soon!".colorize(:blue)
    end
    
end