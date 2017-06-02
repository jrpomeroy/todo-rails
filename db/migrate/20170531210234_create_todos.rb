class CreateTodos < ActiveRecord::Migration[5.1]
  def change
    create_table :todos do |t|
      t.references :user, foreign_key: true
      t.text :description
      t.boolean :complete

      t.timestamps
    end
  end
end
