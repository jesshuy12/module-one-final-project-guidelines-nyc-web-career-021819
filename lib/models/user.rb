#require_relative "../config/environment.rb"

class User < ActiveRecord::Base
   has_many :searches
   has_many :jobs, through: :searches


def self.create_username(user_input)
  self.create(name: user_input)
end

def self.find_username?(user_input)
  self.all.find_by(name: user_input)
end

def self.view_favorites
  self.jobs
end

end
