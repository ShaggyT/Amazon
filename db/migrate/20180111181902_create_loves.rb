class CreateLoves < ActiveRecord::Migration[5.1]
  def change
    create_table :loves do |t|
      t.references :review, foreign_key: true, index: true
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
