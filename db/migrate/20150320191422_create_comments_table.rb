class CreateCommentsTable < ActiveRecord::Migration
  def change
    create_table :comments_tables do |t|
      t.string :text

      t.timestamps
    end
  end
end
