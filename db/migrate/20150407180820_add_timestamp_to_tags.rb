class AddTimestampToTags < ActiveRecord::Migration
  def change
    add_column :tags, :timestamp, :datetime
  end
end
