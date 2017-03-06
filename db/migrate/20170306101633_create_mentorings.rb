class CreateMentorings < ActiveRecord::Migration[5.0]
  def change
    create_table :mentorings do |t|
      t.integer :mentor_id, null: false
      t.integer :mentee_id, null: false

      t.timestamps
    end

    add_index :mentorings, :mentor_id
    add_index :mentorings, :mentee_id
  end
end
