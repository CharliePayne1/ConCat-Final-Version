require_relative '../config/environment'

#YOU SHOULD BE ABLE TO SEE THIS

#welcome message
puts "DEVs = making logo "
puts" "
puts "Welcome to DEVS, the tool that matches you with a developer to bring your App to life!"
puts " "

#input new user name
puts "To get started, tell us your name:"
new_user_name = gets.chomp

#  puts start_sentence(user_name) #What is this?
#input project language
puts " "
puts "Thanks #{new_user_name}, now let us know which program you want your app built in:"
new_app_language = gets.chomp

#iertate over all the developers and find someone who specialises in that same language
developer = Developer.all.select {|developer| developer.language == new_app_language}[0]

#show the user their match
puts "Congratulations, we've matched you with #{developer.name}, who is an expert in #{new_app_language}."
puts " "

#get the name of the new app to create a new project instance
puts "If you'd like to start working with #{developer.name}, tell us the name of your new app:"
new_app_name = gets.chomp

#create a new project instance 

Project.create(name: "#{new_app_name}")
puts "Okay great, we've created a new project for you and #{developer.name} to start working on #{new_app_name}."

#display all avaiable categories
#put the new project to the category
puts "To be more organize, you can fall your app into a category. Your choice is:"
app_category = gets.chomp

# puts "Okay, we've found #{response.count]} developer(s) that match(es) your request." # ??????
#
# if response.count > 0
#     reponse.count["results"].each do |developer|
#         puts "~ #{developer.name}"
#     end
# else
#     puts "So sorry, but there are no results for your request. Just start again!"
# end
# puts list_of_developers
# puts "Put the name of develper you want to start work with:"
# developer_name = gets.chomp
# puts "Congratulation! You find you developer!"
# puts "We would like to save it for you, so please put the name of your app:"
# app_name = gets.chomp
# puts "To be more organize, you can fall your app into a category:"
# app_category = gets.chomp
# puts pre_conslusion
# app.create # ???????
# puts conslusion
# app.read # ??????
# puts "Change the mind? no worries! You cam update or cancel your app any time!"
# puts "Just type the name of the app you would like to update/cancel. We'll find it for you!"
# app_name_choosen = gets.chomp
# # TRUE - "Okay, we've cancelled your project, and let [DEVELOPERS NAME] know too." ?????
# # FALSE - "I'm sorry, we can't find that project. Try calling [07939188944] for further assistance."
# puts "What do you would like to do:"
# # choose cancel update
# # # if choose update
# # updating
# # if choose cancel cancel
# app.update
# puts "Okay, we have updated #{app_name_choosen}."
# app.delete
# puts "Okay, we have cancelled #{app_name_choosen}."
# puts "Bye!!!"
# # methods
#   def start_sentence(user_name)
#     "#{user_name}, let's bring together your app to life!!!"
#   end
#   def results(programmer_language, app_location)
#     "We find for you the best developers at #{programmer_language} in #{app_location}:"
#   end
#   def response_count
#   end
#   def list_of_developers
#   end
#   def pre_conslusion
#     "HURRA!!! ALL SET! NOW JUST START ENJOY TO PROCCES BUIDING #{app_name}!"
#   end
#   def conslusion
#     puts "#{user_name} has created the app #{app_name} in category #{app_category} with
#     #{developer_name} at #{rogrammer_language} in #{app_location}!"
#   end
#   def app.create
#   end
#   def app.read
#   end
#   def app.update
#   end
#   def app.cancel
#   end
# #  When back to app again: - Not sure if we have the tome for it
# # enter your name
# # If we have the name
# # Hello, name. You have the saved the apps below
# MESSAGE 05.05.2019