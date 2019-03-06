class Job < ActiveRecord::Base
  has_many :searches
  has_many :users, through: :searches


  def self.find_job?(user_input)
    self.all.find_by(title: user_input)
  end


end
