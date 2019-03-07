class CLI

  attr_accessor :user

def greeting
 puts " "
 puts "Welcome to Job-ly, a simple way to find jobs!".colorize(:yellow)
 puts " "
end

################################################################################

def starting_menu_showcase
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
  puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  puts "Job-ly is a command line interface app that allows users to search up jobs
   based on a keyword. Users also have the option to save jobs that interest them!"
  puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  puts "To return back to Main Menu, please enter 'return'"
  user_input = gets.chomp.downcase
  if user_input == "return"
    starting_menu_showcase
    starting_menu
  else
    puts "Invalid input, please try again.".colorize(:red)
    information
  end
end

################################################################################

def create_user
  puts "                   CREATE USER                     ".colorize(:light_cyan)
  puts "---------------------------------------------------".colorize(:light_cyan)
  puts "Please enter a valid username to create"
  puts "Example Username ----> jessy "
  puts "To return back to main menu, please type 'return'"
  puts "---------------------------------------------------".colorize(:light_cyan)
  user_input = gets.chomp.downcase
    if user_input == "return"
      starting_menu_showcase
      starting_menu
    elsif User.find_username?(user_input) == nil
      User.create_username(user_input)
        puts "Username (#{user_input}) has been created!".colorize(:green)
        puts "Proceed to login with the created username"
      starting_menu_showcase
      starting_menu
    else
      puts "!!Username is not avaliable, please try again!!".colorize(:red)
      create_user
    end
end

################################################################################

  def login
    puts "                     LOGIN                       ".colorize(:light_cyan)
    puts "-------------------------------------------------".colorize(:light_cyan)
    puts "Please enter a valid username"
    puts "To return back to main menu, please type 'return'"
    puts "-------------------------------------------------".colorize(:light_cyan)
      user_input = gets.chomp.downcase
    if user_input == "return"
      starting_menu_showcase
      starting_menu
    elsif User.find_username?(user_input) == nil
      #puts "-------------------------------------------------------------------"
      puts "That username does not have an associated account, please try again".colorize(:red)
      #puts "-------------------------------------------------------------------"
      login
    else
      self.user = User.find_username?(user_input)
      puts "Logged in as #{self.user.name}".colorize(:green)
      logged_in_menu_showcase
      logged_in_menu
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
      puts "Invalid Option, Please Enter a Valid Option".colorize(:red)
      starting_menu
  end
end

################################################################################

def keyword
  puts "                     SEARCH                          ".colorize(:light_cyan)
  puts "-----------------------------------------------------".colorize(:light_cyan)
  puts "Please enter a 'keyword' to search by"
  puts "Example ----> 'cook' "
  puts "To return back to previous menu, please type 'return'"
  puts "-----------------------------------------------------".colorize(:light_cyan)
    # found_jobs = []
    user_input = gets.chomp.downcase
    jobs = Job.find_job?(user_input)
  if user_input == "return"
    logged_in_menu_showcase
    logged_in_menu
  elsif jobs == nil
    puts "There are no jobs avaliable at the moment".colorize(:red)
    puts "            Please try again             ".colorize(:red)
      keyword
  #else
    #puts jobs.title
    #this doesnt really work
  end
  #found_jobs
    puts "Would you like to save the job?"
    puts "Enter (Yes) to save".colorize(:green)
    puts "Enter (No) to search again".colorize(:red)
      answer = gets.chomp.downcase
      if answer == "yes"
        #binding.pry
        Search.save(self.user.id, jobs.id, user_input)
        puts "That job has been saved to your favorites!".colorize(:green)
        puts "Returning back to search menu"
        keyword
      else
        puts "Search Again".colorize(:red)
        keyword
      end
end

################################################################################

  def view_favorites
    puts "To view saved jobs, please enter 'view'"
    puts "To return back to previous menu, please enter 'return'"
      puts "               SAVED JOBS                ".colorize(:light_cyan)
      puts "-----------------------------------------".colorize(:light_cyan)
      # @favorites = []
      favorites = self.user.jobs
      favorites.each do |job|
        puts job.title
      end
      puts "-----------------------------------------".colorize(:light_cyan)
        logged_in_menu_showcase
        logged_in_menu
  end

################################################################################

  def delete_jobs
    self.user.jobs.destroy_all
  end

################################################################################

  def delete_favorites
    puts "To delete all saved jobs, please enter 'delete'"
    puts "To return back to previous menu, please type 'return'"
      user_input = gets.chomp.downcase
    if user_input == "delete"
      delete_jobs
      puts "Your saved jobs have been deleted successfully".colorize(:green)
      logged_in_menu_showcase
      logged_in_menu
    elsif user_input == "return"
      logged_in_menu_showcase
      logged_in_menu
    else
      puts "Invalid input, please try again".colorize(:red)
      delete_favorites
    end
  end

################################################################################

# def self.update_username(new_name)
#   user = Self.user.name
#   user.name = new_name
#   user

################################################################################
def update
  puts "Please enter a new username"
    user_input = gets.chomp.downcase
    #binding.pry
    self.user.update(name: user_input)
    # user.name = new_name
  puts "Your new username is #{user_input}".colorize(:green)
    logged_in_menu_showcase
    logged_in_menu
end

################################################################################

  def logged_in_menu_showcase
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
