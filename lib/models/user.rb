#require_relative "../config/environment.rb"

class User < ActiveRecord::Base
   has_many :job_searches
   has_many :jobs, through: :job_searches
end
