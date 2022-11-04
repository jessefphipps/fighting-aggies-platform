class CreateModelApis < ActiveRecord::Migration[7.0]
  def change
    create_table :model_apis do |t|
      t.string :home_team
      t.string :away_team
      t.integer :home_score
      t.integer :away_score
      t.integer :quarter
      t.string :time
      t.string :possession
      t.integer :play_down
      t.integer :yard_to_10
      t.string :play_name
      t.string :qb_name
      t.string :wr1_name
      t.string :wr1_route
      t.boolean :wr1_good_route
      t.string :wr2_name
      t.string :wr2_route
      t.boolean :wr2_good_route
      t.string :te_name
      t.string :te_route
      t.boolean :te_good_route
      t.string :rb_name
      t.string :rb_route
      t.boolean :rb_good_route
      t.string :received_by
      t.integer :yards_gained

      t.timestamps
    end
  end
end
