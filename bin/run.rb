require_relative '../config/environment'
ActiveRecord::Base.logger = false

new_cli = CLI.new

new_cli.greeting
new_cli.starting_menu_showcase
new_cli.starting_menu

#puts "HELLO WORLD"
