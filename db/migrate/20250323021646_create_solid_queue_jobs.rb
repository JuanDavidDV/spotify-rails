class CreateSolidQueueJobs < ActiveRecord::Migration[8.0]
  def change
    create_table :solid_queue_jobs do |t|
      t.string :job_class
      t.text :arguments
      t.datetime :enqueued_at
      t.string :status, default: 'pending'
      t.datetime :completed_at
      t.timestamps
    end
  end
end
