class RemoveTextFromReviews < ActiveRecord::Migration[5.1]
  def change
    remove_column :reviews, :text, :string
  end
end
