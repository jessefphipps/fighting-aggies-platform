class Analysis < ApplicationRecord
    belongs_to :video
    def initialize(video_id)
        # Return if video does not exist
        raise "Video with id " + video_id.to_s + " does not exist" and return unless Video.exists?(id: video_id)
        
        # Return if vision does not exist
        raise "Vision for video with id " + video_id.to_s + " does not exist" and return unless Vision.exists?(video_id: video_id)
        
        # Return if analysis exists for the requested video_id
        raise "Analysis for video with id " + video_id.to_s + " already exists" and return if Analysis.exists?(video_id: video_id)
        
        report = generate_random_report()

        super({ :report => report, :video_id => video_id})
    end
    
    private
    def generate_random_report()
        # fixed report for now
        report = {
            'Offense' => [{
                'component' => 'piechart',
                'title' => 'Point Distribution',
                'data' => [{
                    'name' => 'Passing Touchdown Points',
                    'value' => [0,6,12,18,24,30].sample
                },
                {
                    'name' => 'Rushing Touchdown Points',
                    'value' => [0,6,12,18,24,30].sample
                },
                {
                    'name' => 'Field Goal Points',
                    'value' => [0,3,6,9,12,15,18,21].sample
                },
                {
                    'name' => 'Extra Points',
                    'value' => [0,1,2,3,4,5].sample
                }],
            }, {
                'component' => 'barchart',
                'title' => 'Yards Gained per Play Type',
                'data' => [{
                    'name' => 'Passing',
                    'value' => rand(0..300)
                },
                {
                    'name' => 'Rushing',
                    'value' => rand(0..200)
                }]
            }],
            'Defense' => [{
                'component' => 'barchart',
                'title' => 'Yards Allowed per Play Type',
                'data' => [{
                    'name' => 'Passing',
                    'value' => rand(0..300)
                },{
                    'name' => 'Rushing',
                    'value' => rand(0..300)
                }]
            },{
                'component' => 'piechart',
                'title' => 'Successful Defensive Plays',
                'data' => [{
                    'name' => 'Blitz',
                    'value' => rand(0..30)
                },
                {
                    'name' => 'Man Coverage',
                    'value' => rand(0..30)
                },
                {
                    'name' => 'Zonal Coverage',
                    'value' => rand(0..30)
                }]
            }]
        }
        
        return report.to_json
    end
end
