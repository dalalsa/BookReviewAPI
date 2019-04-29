class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :title
      t.integer :content_rating
      t.integer :recommend_rating
      t.float :average_rating
      t.references :user
      t.references :book

      t.timestamps
    end
  end
end
