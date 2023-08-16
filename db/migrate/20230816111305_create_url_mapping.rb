class CreateUrlMapping < ActiveRecord::Migration[7.0]
  def change
    create_table :url_mappings do |t|
      t.string :long_url
      t.string :short_url
      t.date :expires_at

      t.timestamps
    end
  end
end
