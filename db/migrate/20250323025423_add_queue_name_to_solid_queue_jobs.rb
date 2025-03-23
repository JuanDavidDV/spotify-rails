class AddQueueNameToSolidQueueJobs < ActiveRecord::Migration[8.0]
  def change
    add_column :solid_queue_jobs, :queue_name, :string
  end
end
