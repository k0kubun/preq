class CreatePullRequests < ActiveRecord::Migration
  def change
    create_table :pull_requests do |t|
      t.integer :repository_id
      t.integer :number
      t.string :state
      t.string :title
      t.string :url

      t.timestamps
    end
  end
end
