class SetDefaultPriorityOnSolidQueueJobs < ActiveRecord::Migration[8.0]
  def change
    change_column_default :solid_queue_jobs, :priority, 0
  end
end
