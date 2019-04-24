class CreateOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :options do |t|
    change_column :tasks, :title, :string, null: false
    change_column :tasks, :content, :text, null: false
    end
  end
end
