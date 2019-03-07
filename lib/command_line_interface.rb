class CLI

  attr_accessor :user

################################################################################

  def clear_screen
    cursor = TTY::Cursor
    print cursor.clear_screen
  end

################################################################################

def greeting
 clear_screen
 puts " "
 puts "Welcome to Job-ly, a simple way to find jobs!".colorize(:yellow)
 puts " "
 # a = Artii::Base.new :font => 'slant'
 # puts a.asciify('Job-ly!').colorize(:yellow)
end

################################################################################

def starting_menu_showcase
  clear_screen
  greeting
  a = Artii::Base.new :font => 'slant'
  puts a.asciify('Job-ly!').colorize(:yellow)
  puts " "
  puts "               MAIN MENU                ".colorize(:light_cyan)
  puts "----------------------------------------".colorize(:light_cyan)
  puts "1. Login"
  puts "2. Create New User"
  puts "3. Information About Job-ly"
  puts "4. Exit"
  puts "----------------------------------------".colorize(:light_cyan)
end

################################################################################

def information
  clear_screen
  a = Artii::Base.new :font => 'slant'
  puts a.asciify('Job-ly!').colorize(:yellow)
  puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~".colorize(:light_cyan)
  puts "Job-ly is a command line interface app that allows users to search up jobs based
    on a keyword. Users also have the option to save jobs that interest them!"
  puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~".colorize(:light_cyan)
  puts "To return back to Main Menu, enter any key"
  user_input = gets.chomp.downcase
  if user_input == "return" || "exit"
    clear_screen
    starting_menu_showcase
    starting_menu
  else
    puts "Invalid input, please try again.".colorize(:red)
    information
  end
end

################################################################################

def user_menu_showcase
  puts "                   CREATE USER                     ".colorize(:light_cyan)
  puts "---------------------------------------------------".colorize(:light_cyan)
  puts "Please enter a valid username to create"
  puts "Example Username ----> 'name'"
  puts "To return back to main menu, please type 'return'"
  puts "---------------------------------------------------".colorize(:light_cyan)
end

################################################################################

def create_user
  clear_screen
  user_menu_showcase
  valid = false
  until valid
    user_input = gets.chomp.downcase
    if user_input == "return"
      valid = true
      clear_screen
      starting_menu_showcase
      starting_menu
    elsif User.find_username?(user_input) == nil
      valid = true
      User.create_username(user_input)
      clear_screen
        puts "Username (#{user_input}) has been created!".colorize(:green)
        puts "Proceed to login with the created username".colorize(:green)
        puts "Enter any key to return back to Menu"
        answer = gets.chomp.downcase
      starting_menu_showcase
      starting_menu
    else
      puts "Username not avaliable, please try again!".colorize(:red)
    end
  end
end

################################################################################

def login_info_showcase
  puts "                     LOGIN                       ".colorize(:light_cyan)
  puts "-------------------------------------------------".colorize(:light_cyan)
  puts "Please enter your username"
  puts "To return back to main menu, please type 'return'"
  puts "-------------------------------------------------".colorize(:light_cyan)
end

################################################################################

  def login
    clear_screen
    login_info_showcase
    valid = false
    until valid
      user_input = gets.chomp.downcase
    if user_input == "return"
      valid = true
      clear_screen
      starting_menu_showcase
      starting_menu
    elsif User.find_username?(user_input) == nil
      #puts "-------------------------------------------------------------------"
      puts "That username does not exit, please try again!".colorize(:red)
      #puts "-------------------------------------------------------------------"
    else
      valid = true
      self.user = User.find_username?(user_input)
      clear_screen
      puts "Logged in as (#{self.user.name})".colorize(:green)
      puts " "
      logged_in_menu_showcase
      logged_in_menu
    end
  end
end

################################################################################

def starting_menu
  puts "Please Enter One of the Following Options".colorize(:yellow)
  user_input = gets.chomp.downcase
  case user_input
    when "login", "1"
      login
    when "create new user", "2"
     create_user
    when "information about job-ly", "3"
      information
    when "exit", "4"
      abort("Exiting Application".colorize(:red))
    else
      clear_screen
      puts "Invalid Option, Please Enter a Valid Option".colorize(:red)
      puts " "
      starting_menu_showcase
      starting_menu
  end
end

################################################################################

def keyword_menu
  puts "                     SEARCH                          ".colorize(:light_cyan)
  puts "-----------------------------------------------------".colorize(:light_cyan)
  puts "Please enter a 'keyword' to search by"
  puts "Example ----> 'cook' "
  puts "To return back to User Menu, please type 'return'"
  puts "-----------------------------------------------------".colorize(:light_cyan)
end

################################################################################

def keyword
  clear_screen
  keyword_menu
    valid = false
    until valid
    user_input = gets.chomp.downcase
  if user_input == "return"
    valid = true
    logged_in_menu_showcase
    logged_in_menu
  elsif Job.find_job?(user_input) == nil
    puts "Could not find any jobs related to that keyword".colorize(:red)
    puts "               Please try again                ".colorize(:red)
  else
    Job.find_job?(user_input)
    puts "Would you like to save the job?"
    puts "Enter (Yes) to save".colorize(:green)
    puts "Enter (No) to search again".colorize(:red)
      answer = gets.chomp.downcase
      case answer
      when "yes", "y"
        #binding.pry
        clear_screen
        a = Artii::Base.new
        puts a.asciify('SAVED').colorize(:green)
        Search.save(self.user.id, Job.find_job?(user_input).id, user_input)
        puts "That job has been saved to your favorites!".colorize(:green)
        puts "Enter a keyword to search again".colorize(:yellow)
        puts "Enter return to go back to User Menu".colorize(:red)
      when "no", "n"
        clear_screen
        puts "Enter a keyword to search again".colorize(:yellow)
        puts "Enter return to go back to User Menu".colorize(:red)
      end
    end
  end
end

################################################################################

  def view_favorites
    clear_screen
    #if user_input == "view"
      puts "               SAVED JOBS                ".colorize(:light_cyan)
      puts "-----------------------------------------".colorize(:light_cyan)
      # @favorites = []
      favorites = self.user.jobs
      favorites.each do |job|
        puts job.title
      end
      puts "-----------------------------------------".colorize(:light_cyan)
      puts "Enter any key to return back to User Menu".colorize(:yellow)
      user_input = gets.chomp.downcase
        logged_in_menu_showcase
        logged_in_menu
end

################################################################################

  def delete_jobs
    self.user.jobs.destroy_all
  end

################################################################################

  def delete_favorites
    clear_screen
    a = Artii::Base.new
    puts a.asciify('WARNING').colorize(:red)
    puts "To delete all saved jobs, please enter 'i want to delete'".colorize(:red)
    puts "To return back to previous menu, please type 'return'".colorize(:yellow)
    valid = false
    until valid
      user_input = gets.chomp.downcase
    if user_input == "i want to delete"
      valid = true
      delete_jobs
      puts "Your saved jobs have been deleted successfully".colorize(:green)
      puts "Enter any key to return back to User Menu".colorize(:yellow)
      answer = gets.chomp.downcase
      logged_in_menu_showcase
      logged_in_menu
    elsif user_input == "return"
      valid = true
      logged_in_menu_showcase
      logged_in_menu
    else
      puts "Invalid input, please try again".colorize(:red)
    end

    end

  end

################################################################################

# def self.update_username(new_name)
#   user = Self.user.name
#   user.name = new_name
#   user

################################################################################
def update
  clear_screen
  puts "Please enter a new username".colorize(:yellow)
    user_input = gets.chomp.downcase
    #binding.pry
    self.user.update(name: user_input)
    # user.name = new_name
  puts "Your new username is #{user_input}".colorize(:green)
  puts "Enter any key to return back to User Menu".colorize(:yellow)
  answer = gets.chomp.downcase
    logged_in_menu_showcase
    logged_in_menu
end

################################################################################

  def logged_in_menu_showcase
    clear_screen
    puts "               USER MENU                 ".colorize(:light_cyan)
    puts "-----------------------------------------".colorize(:light_cyan)
    puts "1. Search by keyword"
    puts "2. View Favorites"
    puts "3. Delete Favorites"
    puts "4. Update Username"
    puts "5. Return to Main Menu"
    puts "-----------------------------------------".colorize(:light_cyan)
  end

################################################################################

  def logged_in_menu
    puts "Please Enter One of the Following Options".colorize(:yellow)
    user_input = gets.chomp.downcase
    case user_input
    when "search by keyword", "1"
      keyword
    when "view favorites", "2"
      view_favorites
    when "delete favorites", "3"
      delete_favorites
    when "update username", "4"
      update
    when "return to main menu", "5", "exit", "return"
      puts "Returning to Main Menu"
      starting_menu_showcase
      starting_menu
    else
      puts "Invalid Option, Please Enter a Valid Option".colorize(:red)
      logged_in_menu_showcase
      logged_in_menu
    end
end

################################################################################

end
