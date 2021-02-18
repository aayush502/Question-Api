class CreateQuestionDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :question_details do |t|
      t.integer :question_token
      t.integer :x1
      t.integer :y1
      t.integer :x2
      t.integer :y2
      t.string :value

      t.timestamps
    end
  end
end
