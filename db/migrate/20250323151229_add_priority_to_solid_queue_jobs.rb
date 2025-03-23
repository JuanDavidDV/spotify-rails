class AddPriorityToSolidQueueJobs < ActiveRecord::Migration[8.0]
  def change
    add_column :solid_queue_jobs, :priority, :integer
  end
end
