class CreateComments < ActiveRecord::Migration[8.1]
  def change
    create_table :comments do |t|
      t.text :message
      t.references :task, null: false, foreign_key: true
      t.bigint :created_by
      t.bigint :comment_id

      t.timestamps
    end
  end
end
