class CreateVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :videos do |t|
      t.string :video_path
      t.string :thumbnail_path
      t.string :resolution
      t.integer :size
      t.integer :duration
      t.float :frame_rate

      t.timestamps
    end
  end
end
