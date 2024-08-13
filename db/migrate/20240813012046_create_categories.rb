class CreateCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :categories do |t|
      t.timestamps
      t.string :name
    end
  end
end
