require_relative '../config/environment'
require "tty-prompt"


prompt = TTY::Prompt.new
spinner = TTY::Spinner.new

CLI.loading_bar

#welcome message
CLI.greet

#input new user name (CREATE)
name = prompt.ask("To get started, tell us your name:".colorize(:yellow))
# new_user = User.find_or_create_by(name: "#{new_user_name}")
puts " "

#new user or existing user
user = User.all.find {|user| user.name == name}
if user == nil 
    user = User.create(name: "#{name}")
    puts "Looks, like you're new to ConCat #{name}, so we've set you up with a new profile."
else
    puts "Nice to see you again #{name}!"
    puts " "
    active_projects = prompt.yes?("Hey #{name}! Would you like to look at your active projects?".colorize(:yellow))
    CLI.loading_bar
    if active_projects
        project_names = user.projects.map {|project| project.name}
            if project_names.length == 0
            puts "You don't have any active projects, let's change that!.".colorize(:red)
            else
                string = project_names.join(", ")
            puts "Here are all the names of your active projects: #{string}.".colorize(:green)
            end
    else
    puts "That means you must have a new App idea!".colorize(:yellow)
    end
end

#input project language (READ)
puts " "
new_project = prompt.yes?("Would you like to create a new app?".colorize(:yellow))
if new_project
    CLI.loading_bar 
    new_app_language = prompt.select("Thanks for choosing ConCat to create your new app #{name}, now let us know which program you want your new app built in:", %w(PPL es Oz Rlab HyperTalk Unicon Harbour FlooP TypeScript TEX Golo NWScript Hermes SystemVerilog Ratfor M# PL/SQL))
    developer = Developer.all.find {|developer| developer.language == new_app_language}
    CLI.loading_bar

    #show the user their match 
    puts "Congratulations, we've matched you with #{developer.name}, who is an expert in #{new_app_language}.".colorize(:green)
    puts " " 

    #get the name of the new app & category to create a new project instance
    new_app_name = prompt.ask("If you'd like to start working with #{developer.name}, tell us the name of your new app:".colorize(:yellow))
    app_category = prompt.select("And the category this falls into:", %w(Banking Communicaton E-Commerce Fitness Gaming Healthcare Pharmaceuticals TOP-SECRET Travel))
    CLI.loading_bar

#create a new project instance (CREATE)
    Project.create(name: "#{new_app_name}", category: "#{app_category}", developer_id: developer.id, user_id: user.id)
    puts "Okay great, we've created a new project for you and #{developer.name} to start working on #{new_app_name} together.".colorize(:green)
    puts " "
    puts "Drop them an email to say hi and get started on #{developer.email}.".colorize(:green)
    puts " "

else
    puts " "
    puts "Okay, we'll move on."
    puts " "
end

#update the name of your project (UPDATE)
update_answer = prompt.yes?('Would you like to change the name of any of your apps?'.colorize(:yellow))
        if update_answer
            puts " "
            original_app_name = prompt.ask("To help us find your app, what did you call it originally?".colorize(:yellow))
            original_app = Project.find_by(name: "#{original_app_name}")
            puts " "
            CLI.loading_bar
            updated_app_name = prompt.ask('Found it! Now, what would you like to change the name to?'.colorize(:green))
            original_app.update(name: "#{updated_app_name}")
            CLI.loading_bar

        puts "Nice choice, we've changed your app to be called #{updated_app_name}.".colorize(:green)
        puts " "

        else
            CLI.loading_bar
            puts " "
            puts "If it ain't broke, don't fix it, right!"
            puts " "
        end

#delete the new project (DELETE)
delete_project = prompt.yes?('Would you like to cancel a project?')
if delete_project
    puts " "
    app_name = prompt.ask("To help us find your app, what did you call your it?".colorize(:yellow))
    app = Project.find_by(name: "#{app_name}")
    app.delete
    CLI.loading_bar
    puts " "
    puts "Okay, we've deleted this project for you.".colorize(:green)

else
    puts " "
    puts "Great, can't wait to see your work!.".colorize(:green)

end

CLI.goodbye

