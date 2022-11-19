class Analysis < ApplicationRecord
    belongs_to :video
    def initialize(video_id)
        # Return if video does not exist
        raise "Video with id " + video_id.to_s + " does not exist" and return unless Video.exists?(id: video_id)
        
        vision = Vision.find_by(video_id: video_id)
        if vision == nil
            vision = Vision.create(video_id)
        end
        
        # Return if analysis exists for the requested video_id
        raise "Analysis for video with id " + video_id.to_s + " already exists" and return if Analysis.exists?(video_id: video_id)
        
        report = generate_random_report(vision.report)

        super({ :report => report, :video_id => video_id})
    end
    
    private
    
    def generate_random_report(raw_data)
        parsed_raw_data = JSON.parse(raw_data)

        play_success = parsed_raw_data['play_success'] == 1 ? 'Pass' : 'Fail'
        route_wr1_success = parsed_raw_data['WR1_good_route'] == 1 ? 'Pass' : 'Fail'
        route_wr2_success = parsed_raw_data['WR2_good_route'] == 1 ? 'Pass' : 'Fail'
        route_te_success = parsed_raw_data['TE_good_route'] == 1 ? 'Pass' : 'Fail'
        route_rb_success = parsed_raw_data['RB_good_route'] == 1 ? 'Pass' : 'Fail'
        wr1_yards_gained = parsed_raw_data['WR1_name'] == parsed_raw_data['received_by'] ? parsed_raw_data['yards_gained'] : 0
        wr2_yards_gained = parsed_raw_data['WR2_name'] == parsed_raw_data['received_by'] ? parsed_raw_data['yards_gained'] : 0
        te_yards_gained = parsed_raw_data['TE_name'] == parsed_raw_data['received_by'] ? parsed_raw_data['yards_gained'] : 0
        rb_yards_gained = parsed_raw_data['RB_name'] == parsed_raw_data['received_by'] ? parsed_raw_data['yards_gained'] : 0
        
        players_good_routes = 0
        players_bad_routes = 0
        for a in [parsed_raw_data['WR1_good_route'],parsed_raw_data['WR2_good_route'],parsed_raw_data['TE_good_route'],parsed_raw_data['RB_good_route']] do 
            if a==1
                players_good_routes += 1
            else
                players_bad_routes += 1
            end
        end

        frontend_report = {
            'Offense' => [{
                'component' => 'piechart',
                'title' => 'Success rate of play',
                'data' => [{
                    'name' => 'Pass',
                    'value' => players_good_routes
                },{
                    'name' => 'Fail',
                    'value' => players_bad_routes
                }]
            }, {
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
            }],
            'Players' => [{
                'component' => 'card',
                'data' => {
                    'name' => parsed_raw_data['QB_name'],
                    'position' => 'Quarterback',
                    'play_success' => play_success,
                    'play_name' => parsed_raw_data['play_name'],
                    'yards_gained' => parsed_raw_data['yards_gained']
                },
            }, {
                'component' => 'card',
                'data' => {
                    'name' => parsed_raw_data['WR1_name'],
                    'position' => 'Wide Receiver 1',
                    'play_success' => play_success,
                    'play_name' => parsed_raw_data['play_name'],
                    'route_name' => parsed_raw_data['WR1_route'],
                    'route_success' => route_wr1_success,
                    'yards_gained' => wr1_yards_gained
                },
            },{
                'component' => 'card',
                'data' => {
                    'name' => parsed_raw_data['WR2_name'],
                    'position' => 'Wide Receiver 2',
                    'play_success' => play_success,
                    'play_name' => parsed_raw_data['play_name'],
                    'route_name' => parsed_raw_data['WR2_route'],
                    'route_success' => route_wr2_success,
                    'yards_gained' => wr2_yards_gained
                }
            },{
                'component' => 'card',
                'data' => {
                    'name' => parsed_raw_data['TE_name'],
                    'position' => 'Tight End',
                    'play_success' => play_success,
                    'play_name' => parsed_raw_data['play_name'],
                    'route_name' => parsed_raw_data['TE_route'],
                    'route_success' => route_te_success,
                    'yards_gained' => te_yards_gained
                }
            },{
                'component' => 'card',
                'data' => {
                    'name' => parsed_raw_data['RB_name'],
                    'position' => 'Running Back',
                    'play_success' => play_success,
                    'play_name' => parsed_raw_data['play_name'],
                    'route_name' => parsed_raw_data['RB_route'],
                    'route_success' => route_rb_success,
                    'yards_gained' => rb_yards_gained
                }
            }]
        }
        
        return frontend_report.to_json
    end
    
    # def generate_random_report()
    #     # fixed report for now
    #     report = {
    #         'Offense' => [{
    #             'component' => 'piechart',
    #             'title' => 'Point Distribution',
    #             'data' => [{
    #                 'name' => 'Passing Touchdown Points',
    #                 'value' => [0,6,12,18,24,30].sample
    #             },
    #             {
    #                 'name' => 'Rushing Touchdown Points',
    #                 'value' => [0,6,12,18,24,30].sample
    #             },
    #             {
    #                 'name' => 'Field Goal Points',
    #                 'value' => [0,3,6,9,12,15,18,21].sample
    #             },
    #             {
    #                 'name' => 'Extra Points',
    #                 'value' => [0,1,2,3,4,5].sample
    #             }],
    #         }, {
    #             'component' => 'barchart',
    #             'title' => 'Yards Gained per Play Type',
    #             'data' => [{
    #                 'name' => 'Passing',
    #                 'value' => rand(0..300)
    #             },
    #             {
    #                 'name' => 'Rushing',
    #                 'value' => rand(0..200)
    #             }]
    #         }],
    #         'Defense' => [{
    #             'component' => 'barchart',
    #             'title' => 'Yards Allowed per Play Type',
    #             'data' => [{
    #                 'name' => 'Passing',
    #                 'value' => rand(0..300)
    #             },{
    #                 'name' => 'Rushing',
    #                 'value' => rand(0..300)
    #             }]
    #         },{
    #             'component' => 'piechart',
    #             'title' => 'Successful Defensive Plays',
    #             'data' => [{
    #                 'name' => 'Blitz',
    #                 'value' => rand(0..30)
    #             },
    #             {
    #                 'name' => 'Man Coverage',
    #                 'value' => rand(0..30)
    #             },
    #             {
    #                 'name' => 'Zonal Coverage',
    #                 'value' => rand(0..30)
    #             }]
    #         }]
    #     }
        
    #     return report.to_json
    # end
end
