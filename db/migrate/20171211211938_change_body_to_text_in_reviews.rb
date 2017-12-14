class ChangeBodyToTextInReviews < ActiveRecord::Migration[5.1]
  def change
    change_column :reviews, :body, :text
  end
end
