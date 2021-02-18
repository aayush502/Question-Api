class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :Qustion
      t.integer :token
      t.string :picture_token

      t.timestamps
    end
  end
end
