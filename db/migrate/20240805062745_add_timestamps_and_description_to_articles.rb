class AddTimestampsAndDescriptionToArticles < ActiveRecord::Migration[7.2]
  def change
    # add_column :articles, :created_at, :datetime #ini dua udh ada by default jdinya tinggal nambahin descripion aja
    # add_column :articles, :created_at, :datetime
    add_column :articles, :description, :text
  end
end
