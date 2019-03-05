#require_relative "../config/environment.rb"

class User < ActiveRecord::Base
   has_many :job_searches
   has_many :jobs, through: :job_searches
end

def self.create_username(user_input)
  self.create(name: user_input)
end

def self.find_username(user_input)
  self.find_by(name: user_input)
end
