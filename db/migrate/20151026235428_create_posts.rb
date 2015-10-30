class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, default: ""
      t.string :slug,  default: ""
      t.string :summary, default: ""
      t.text :body_markdown, default: ""
      t.text :body_html,     default: ""
      t.datetime :published_at, null: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :posts, :slug, unique: true
  end
end
