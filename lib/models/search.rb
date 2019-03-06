class Search < ActiveRecord::Base
   belongs_to :user
   belongs_to :job

   def self.save(user_id, job_id, keyword)
     self.create(user_id: user_id, job_id: job_id, keyword: keyword)
   end
end
