class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.integer :from_user_id, null: false
      t.integer :to_user_id, null: false
      t.string :status, null: false
      t.text :description, null: false

      t.timestamps
    end

    add_index :questions, :from_user_id
    add_index :questions, :to_user_id
  end
end
