require_relative 'config/environment'
require 'sinatra/activerecord/rake'

desc 'starts a console'
task :console do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  Pry.start
end


desc 'gets jobs from API and adds to the databse'
task :get_jobs do
  puts "we are here"
  #binding.pry
  # make a request to the api

  # get the results

  # iterate over the results
    # Job.find_or_create_by(name: name, description: description)
  # end
end
