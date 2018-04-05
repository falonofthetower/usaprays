class CreateTaskRun < ActiveRecord::Migration
  def up
    create_table :task_runs do |t|
      t.string :name
      t.date :last, :default => DateTime.new(1980)

      t.timestamps
    end
  end

  def down
    drop_table :task_runs
  end
end
