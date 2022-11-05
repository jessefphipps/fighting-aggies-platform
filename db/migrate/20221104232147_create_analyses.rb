class CreateAnalyses < ActiveRecord::Migration[7.0]
  def change
    create_table :analyses do |t|
      t.json :report
      t.timestamps
      t.belongs_to :video, foreign_key: true
    end
  end
end
