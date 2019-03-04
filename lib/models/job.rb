class Job < ActiveRecord::Base
  has_many :job_searches
  has_many :users, through: :job_searches
end
