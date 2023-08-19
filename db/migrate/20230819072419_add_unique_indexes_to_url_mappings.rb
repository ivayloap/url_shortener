class AddUniqueIndexesToUrlMappings < ActiveRecord::Migration[7.0]
  def change
    add_index :url_mappings, :long_url, unique: true
    add_index :url_mappings, :short_url, unique: true
  end
end
