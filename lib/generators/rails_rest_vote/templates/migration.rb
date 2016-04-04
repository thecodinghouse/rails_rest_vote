class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :vote
      t.integer :votable_id
      t.string  :votable_type
      t.timestamps null: false
    end

    add_reference :votes, :user, index: true, foreign_key: true

  end
end
