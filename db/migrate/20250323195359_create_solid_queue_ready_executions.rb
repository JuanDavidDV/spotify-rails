class CreateSolidQueueReadyExecutions < ActiveRecord::Migration[8.0]
  def change
    create_table :solid_queue_ready_executions do |t|
      t.timestamps
      t.bigint :job_id
      t.datetime :ready_at
    end
  end
end
