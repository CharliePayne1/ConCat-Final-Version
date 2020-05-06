require_relative '../config/environment'
require "tty-prompt"

prompt = TTY::Prompt.new

#welcome message
CLI.greet

#input new user name
new_user_name = prompt.ask("To get started, tell us your name:")
new_user = User.find_or_create_by(name: "#{new_user_name}")

#look at current projects 
active_projects = prompt.yes?("Would you like to look at your active projects?")
if active_projects
    project_names = new_user.projects.map {|project| project.name}
    if project_names.length == 0
        puts "You don't have any active projects."
    else
        puts "Here are all the names of your active projects: #{project_names.to_s}."
    end
else
    puts "That means you must have a new App idea!"
end

#input project language
new_app_language = prompt.select("Thanks for choosing ConCat to create your new a #{new_user_name}, now let us know which program you want your new app built in:", %w(PPL es Oz Rlab HyperTalk Unicon Harbour FlooP TypeScript TEX Golo NWScript Hermes SystemVerilog Ratfor M# PL/SQL))
developer = Developer.all.find {|developer| developer.language == new_app_language}

#show the user their match
puts "Congratulations, we've matched you with #{developer.name}, who is an expert in #{new_app_language}.".colorize(:green)
puts " "

#get the name of the new app & category to create a new project instance
new_app_name = prompt.ask("If you'd like to start working with #{developer.name}, tell us the name of your new app:")
app_category = prompt.select("And the category this falls into:", %w(Banking E-Commerce Gaming Healthcare Pharmaceuticals Travel))

#create a new project instance 
Project.create(name: "#{new_app_name}", category: "#{app_category}", developer_id: developer.id, user_id: new_user.id)
puts "Okay great, we've created a new project for you and #{developer.name} to start working on #{new_app_name}."
puts "Drop them an email to say hi and introduce yourself on #{developer.email} to get started."


#update the name of your project
update_answer = prompt.yes?('Would you like to change the name of your app?')
        if update_answer
            original_app_name = prompt.ask("To help us find your app, what did you call it originally?")
            original_app = Project.find_by(name: "#{original_app_name}")

            updated_app_name = prompt.ask('Found it! Now, what would you like to change the name to?')
            original_app.update(name: "#{updated_app_name}")

        puts "Great, we've changed your app to be called #{updated_app_name}."

        else
            puts "Nice, we like #{new_app_name} too."
        end

#delete the new project
delete_project = prompt.yes?('Would you like to cancel a project?')
if delete_project
    app_name = prompt.ask("To help us find your app, what did you call your it?")
    app = Project.find_by(name: "#{app_name}")
    app.delete

    puts "Okay, we've deleted this project for you."

else
    puts "Great, can't wait to see it when it's done."

end

CLI.goodbye

