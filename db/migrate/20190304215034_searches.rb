class Searches < ActiveRecord::Migration[5.0]
  def change
      create_table :searches do |t|
        t.integer :user_id
        t.integer :job_id
      end
  end
end
