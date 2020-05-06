require_relative '../config/environment'
require "tty-prompt"

prompt = TTY::Prompt.new

#YOU SHOULD BE ABLE TO SEE THIS

#welcome message
puts "Welcome to DEVS, the tool that matches you with a developer to bring your App to life!"
puts " "

#input new user name
puts "To get started, tell us your name:"
new_user_name = gets.chomp
new_user = User.create(name: "#{new_user_name}")

#input project language
puts " "
new_app_language = prompt.select("Thanks #{new_user_name}, now let us know which program you want your app built in:", %w(PPL es Oz Rlab HyperTalk Unicon Harbour FlooP TypeScript TEX Golo NWScript Hermes SystemVerilog Ratfor M# PL/SQL))
developer = Developer.all.select {|developer| developer.language == new_app_language}[0]

#show the user their match
puts "Congratulations, we've matched you with #{developer.name}, who is an expert in #{new_app_language}."
puts " "

#get the name of the new app to create a new project instance
puts "If you'd like to start working with #{developer.name}, tell us the name of your new app:"
new_app_name = gets.chomp

puts "And the category this falls into:"
app_category = gets.chomp

#create a new project instance 

Project.create(name: "#{new_app_name}", category: "#{app_category}", developer_id: developer.id, user_id: new_user.id)
puts "Okay great, we've created a new project for you and #{developer.name} to start working on #{new_app_name}."
puts "Drop them an email to say hi on #{developer.email} to get started."


#update the name of your project
update_answer = prompt.yes?('Would you like to change the name of your app?')
if update_answer
    original_app_name = prompt.ask("To help us find your app, what did you call it originally?")
    original_app = Project.find_by(name: "#{original_app_name}")

    updated_app_name = prompt.ask('Found it! Now, what would like to change the name to?')
    original_app.update(name: "#{updated_app_name}")

    puts "Great, we've changed your app to be called #{updated_app_name}."

else
    puts "Nice, we like #{new_app_name} too."

end

#delete the new project
delete_project = prompt.yes?('Would you like to cancel this project?')
if delete_project
    app_name = prompt.ask("To help us find your app, what did you call your app?")
    app = Project.find_by(name: "#{app_name}")
    app.delete

    puts "Okay, we've deleted this project for you."

else
    puts "Great, can't wait to see it when it's done."

end