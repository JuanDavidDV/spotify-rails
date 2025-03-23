class AddConcurrencyKeyToSolidQueueJobs < ActiveRecord::Migration[8.0]
  def change
    add_column :solid_queue_jobs, :concurrency_key, :string
  end
end
