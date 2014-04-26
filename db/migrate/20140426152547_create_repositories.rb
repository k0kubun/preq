class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.integer :user_id
      t.string :owner
      t.string :name
      t.string :url
      t.boolean :contributed
      t.integer :stargazers_count

      t.timestamps
    end
  end
end
