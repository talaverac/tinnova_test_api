class CreateBeers < ActiveRecord::Migration[5.2]
  def change
    create_table :beers do |t|
    	t.integer :beer_id
    	t.string :name
    	t.string :tagline
    	t.string :description
    	t.string :abv
    	t.datetime :seen_at
    	t.integer :user_id
    	t.boolean :favorite, :default => false
    end
  end
end
