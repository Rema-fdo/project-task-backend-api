class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.date :due_date
      t.date :actual_start_date
      t.date :actual_end_date
      t.string :team
      t.references :status, null: false, foreign_key: true
      t.references :priority, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.bigint :parent_task_id
      t.bigint :created_by
      t.bigint :updated_by

      t.timestamps
    end
  end
end
