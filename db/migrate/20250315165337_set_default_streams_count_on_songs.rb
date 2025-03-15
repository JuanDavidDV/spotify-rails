class SetDefaultStreamsCountOnSongs < ActiveRecord::Migration[8.0]
  def change
    change_column_default :songs, :streams_count, 0
  end
end
