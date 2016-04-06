class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :vote #used only for up down vote usage, not for like unlike feature.
      t.references :votable, :polymorphic => true
      t.timestamps null: false
    end

    #user table reference added.
    add_reference :votes, :user, index: true, foreign_key: true
  end
end
