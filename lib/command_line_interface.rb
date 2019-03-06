class CLI

  attr_accessor :user

def greeting
 puts "Welcome to Job-ly, a simple way to find jobs!"
end

def starting_menu_showcase
  puts "               MAIN MENU                "
  puts "----------------------------------------"
  puts "1. Login"
  puts "2. Create New User"
  puts "3. Information About Job-ly"
  puts "4. Exit"
  puts "----------------------------------------"
end

def information
  puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  puts "Job-ly is a command line interface app that allows users to search up jobs
  based on a keyword. Users also have the option to save jobs that interest them!"
  puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  puts "To return back to Main Menu, please enter 'return'"
  user_input = gets.chomp.downcase
  if user_input == "return"
    starting_menu_showcase
    starting_menu
  else
    puts "Invalid input, please try again."
    information
  end

end

def create_user
  puts "---------------------------------------------------"
  puts "Please enter a valid username to create"
  puts "Example Username ----> jessy "
  puts "To return back to main menu, please type 'return'"
  user_input = gets.chomp.downcase
    if user_input == "return"
      starting_menu_showcase
      starting_menu
    # else
    #   puts "Invalid input, please try again"
    #   create_user
    # end
  elsif User.find_username?(user_input) == nil  #create User.find_username in user.rb
      User.create_username(user_input)
      puts "Username (#{user_input}) has been created!"
      puts "Proceed to login with the created username"
      starting_menu_showcase
      starting_menu
    else
      puts "-----------------------------------------------"
      puts "!!Username is not avaliable, please try again!!"
      create_user
    end

end

  def login
    puts "---------------------------------------------------"
    puts "Please enter a valid username"
    puts "To return back to main menu, please type 'return'"
    user_input = gets.chomp.downcase
    if user_input == "return"
      starting_menu_showcase
      starting_menu
    elsif User.find_username?(user_input) == nil
      puts "----------------------------------------------------------------------"
      puts "That username does not have an associated account, please try again"
      puts "----------------------------------------------------------------------"
      login
    else
      self.user = User.find_username?(user_input)
      puts "Logged in as #{self.user.name}"
      logged_in_menu_showcase
      logged_in_menu

    end

  end

def starting_menu
  puts "Please Enter One of the Following Options"
  user_input = gets.chomp.downcase
  case user_input
    when "login", "1"
      login
    when "create new user", "2"
     create_user
    when "information about job-ly", "3"
      information
    when "exit", "4"
      abort("Exiting Application")
    else
      puts "Invalid Option, Please Enter a Valid Option"
      starting_menu
  end
end

def keyword
  puts "Please enter a 'keyword' to search by"
  puts "Example ----> 'cook' "
  puts "To return back to previous menu, please type 'return'"
  found_jobs = []
  user_input = gets.chomp.downcase
  jobs = Job.find_job?(user_input)
  if user_input == "return"
    logged_in_menu_showcase
    logged_in_menu
  elsif jobs == nil
    puts "There are no jobs avaliable at the moment"
    puts "Please try again"
      keyword
  else
    found_jobs << jobs
  end
  found_jobs
    puts "Would you like to save the job?"
    puts "Enter (Yes to save)"
    puts "Enter (No to search again)"
      answer = gets.chomp.downcase
      if answer == "yes"
        #binding.pry
        Search.save(self.user.id, jobs.id, user_input)
      else
        puts "----------------------------------------"
        puts "Search Again"
        keyword
      end
end

  def logged_in_menu_showcase
    puts "               USER MENU                 "
    puts "-----------------------------------------"
    puts "1. Search by keyword"
    puts "2. View Favorites"
    puts "3. Delete Favorites"
    puts "4. Return to Main Menu"
    puts "-----------------------------------------"
  end

  def logged_in_menu
    puts "Please Enter One of the Following Options"
    user_input = gets.chomp.downcase
    case user_input
    when "search by keyword", "1"
      keyword
    when "view favorites", "2"
      #method
    when "delete favorites", "3"
      #method
    when "return to main menu", "4", "exit", "return"
      puts "Returning to Main Menu"
      starting_menu_showcase
      starting_menu
    else
      puts "Invalid Option, Please Enter a Valid Option"
      logged_in_menu_showcase
      logged_in_menu
    end

end

end
