class CreateSnippets < ActiveRecord::Migration
  def self.up
    create_table :snippets do |t|
      t.string :user
      t.string :title
      t.text :contents

      t.timestamps
    end
  end

  def self.down
    drop_table :snippets
  end
end
