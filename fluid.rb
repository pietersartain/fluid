
require './lib/dbhelper'

require 'pp'
require 'JSON'

class Fluid < Sinatra::Base
 
  def initialize(*args)
    super

    # Initialise the database
    @db = Dbhelper.new
  end

  get '/' do
    @db.init
    [200, "All good"]
  end

# View all exercises
  get '/exercises' do
    @exercises = @db.get_exercises
    [200, erb(:exercises)]
  end

# Add new exercise
  post '/exercises' do
    @db.add_exercise(params[:exercise_name], params[:exercise_unit])
    redirect request.path_info
  end

# View all workouts
  get '/workouts' do
    @workouts = @db.get_workouts
    [200, erb(:workouts)]
  end

# Add new workout
  post '/workouts' do
    json = params[:workout]
    workout = JSON.parse(json)

    @db.add_workout(workout["workout_name"], workout["scoring_description"])
    workout_id = @db.last_insert_row_id
    
    workout["workout_exercises"].each do |exercise|
      @db.add_exercise_to_workout(
        workout_id,
        exercise["exercise_id"],
        exercise["exercise_order"],
        exercise["rx_reps"],
        exercise["rx_multiplier"],
        )
    end

    redirect request.path_info
  end

# Record new workout

# Show some crazy results

# "Show me all the times I've done this WoD. Plot results over time."
# "Show me all the pullups I've ever done"
#	"... now include all the exercises I did before a pullup"
#	"Which prior exercises are the most common?"
#	"Which subsquent exercises are the most common?"

end # end class
