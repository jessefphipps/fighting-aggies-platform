class Vision < ApplicationRecord
    belongs_to :video
    def initialize(video_id)
        # Return if video does not exist
        raise "Video with id " + video_id.to_s + " does not exist" and return unless Video.exists?(id: video_id)
        
        # Return if analysis exists for the requested video_id
        raise "Raw data for video with id " + video_id.to_s + " already exists" and return if Vision.exists?(video_id: video_id)
        
        report = generate_random_report()

        super({ :report => report, :video_id => video_id})
    end
    
    def get_rand_yards
        case rand(100)+1
        when 1..60 then rand(0..20)
        when 60..90 then rand(20..60)
        when 90..100 then rand(60..90)
        end
    end
    
    def generate_random_report()
        players = ['Evan Stewart','Muhsin Muhammad III','Max Wright','Donovan Green']
        rbs = ['Devon Achane','Le\'Veon Moss', 'Ainias Smith']
        update = ['Evan Stewart','Muhsin Muhammad III','Max Wright','Donovan Green']
        success = rand(0..1)
        play_type = ['pass','rush'].sample
        play_name = play_type == 'pass' ? ['PA Y-Cross','PA Y-Drag Wheel','Four Verticals'].sample : ['HB Stretch','HB Toss MTN', 'Inside Run'].sample
        yards_gained = success==1 ? get_rand_yards : 0
        received_by = play_type == 'pass' ? players.sample : rbs.sample
        report = {
            'home_team' => 'Texas A&M',
            'away_team' => 'Alabama',
            'home_score' => [3,6,7,12,14,15,18,21,24,27,28].sample,
            'away_score' => [3,6,7,12,14,15,18,21,24,27,28].sample,
            'quarter' => [1,2,3,4].sample,
            'play_down' => [1,2,3,4].sample,
            'yard_to_10' => rand(0..10),
            'play_type' => play_type,
            'play_name' => play_name,
            'play_success' => success,
            'received_by' => received_by,
            'yards_gained' => yards_gained,
            'QB_name' => ['Conner Weigman','Haynes King','Max Johnson'].sample,
            'WR1_name' => update.delete_at(rand(update.length)),
            'WR1_route' => ['Slant','Drag','Post','Fade','Fly','Tackle'].sample,
            'WR1_good_route' => rand(0..1),
            'WR2_name' => update.delete_at(rand(update.length)),
            'WR2_route' => ['Slant','Drag','Post','Fade','Fly','Tackle'].sample,
            'WR2_good_route' => rand(0..1),
            'TE_name' => update.delete_at(rand(update.length)),
            'TE_route' => ['Slant','Drag','Post','Fade','Fly','Tackle'].sample,
            'TE_good_route' => rand(0..1),
            'RB_name' => rbs.sample,
            'RB_route' => ['Slant','Drag','Post','Fade','Fly','Tackle'].sample,
            'RB_good_route' => success
        }
        
        return report.to_json
    end
end
