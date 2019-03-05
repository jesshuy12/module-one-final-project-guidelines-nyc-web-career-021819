def greeting
 puts "Welcome to Job-ly, a simple way to find jobs!"
end

def starting_menu_showcase
  puts "----------------------------------------"
  puts "1. Login"
  puts "2. Create New User"
  puts "3. Information About Job-ly"
  puts "4. Exit"
  puts "----------------------------------------"
end

def information
  puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  puts "Job-ly is a command line interface app that allows users to search up jobs
  based on a keyword. Users also have the option to save jobs that interest them!"
  puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

  puts "To return back to Main Menu, please enter 'exit'"
  user_input = gets.chomp.downcase
  if user_input == "exit"
    starting_menu_showcase
    starting_menu
  else
    puts "Invalid input, please try again."
    information
  end

end

def create_user
  puts "Please enter a valid username"
  puts "To exit back to main menu, please type 'exit'"
  user_input = gets.chomp.downcase
    if user_input == "exit"
      starting_menu_showcase
      starting_menu
    else
      puts "Invalid input, please try again"
      create_user
    end

end

def starting_menu
  puts "Please Enter One of the Following Options"
  user_input = gets.chomp.downcase
  case user_input
    when "login", "1"
    #login_in
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

def logged_in_menu_showcase
  puts "1. Search by keyword"
  puts "2. View Favorites"
  puts "3. Delete Favorites"
  puts "4. Exit"
end

  def logged_in_menu
    puts "Please Enter One of the Following Options"
    user_input = gets.chomp.downcase
    if user_input = "search by keyword" || "1"
      #method
    elsif user_input =  "view favorites" || "2"
      #method
    elsif user_input = "delete favorites" || "3"
      #method
    elsif user_input = "exit" || "4"
      puts ("Returning to Main Menu")
      starting_menu
    else
      puts "Invalid Option, Please Enter a Valid Option"
      logged_in_menu
    end

  # def information
  #   puts "Job-ly is a command line interface app that allows users to search up jobs based on a keyword. Users also have the option to save jobs that interest them!"
  # end

end
