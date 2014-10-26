
require './lib/dbhelper'
require './lib/exercises'
require './lib/workouts'

require 'pp'
require 'JSON'

class Fluid < Sinatra::Base
 
  def initialize(*args)
    super

    # Initialise the database
    @db = Dbhelper.new

    # Initialise the models
    @w = Workouts.new(@db)
    @e = Exercises.new(@db)
  end

  get '/' do
    [200, erb(:layout)]
  end

# View all exercises
  get '/exercises' do
    @exercises = @e.get
    if request.xhr? then
      content_type :json
      @exercise.to_json
    else
      [200, erb(:exercises)]
    end
  end

# Add new exercise
  post '/exercises' do
    @e.add(params[:exercise_name], params[:exercise_unit])
    redirect request.path_info
  end

# ...
  get '/exercise/:type' do
    @details = @e.get_details(params[:type])
    if request.xhr? then
      content_type :json
      @details.to_json
    else
      [200, erb(:exercise_details)]
    end
  end

# View all workouts
  get '/workouts' do
    @workouts = @w.get
    if request.xhr? then
      content_type :json
      @workouts.to_json
    else
      [200, erb(:workouts)]
    end
  end

# Add new workout
  post '/workouts' do
    json = params[:workout]
    workout = JSON.parse(json)

    workout_id = @w.add(
      workout["workout_name"], 
      workout["scoring_description"],
      workout["scoring_unit"]
    )
    
    workout["workout_exercises"].each do |exercise|
      @w.add_exercise(
        workout_id,
        exercise["exercise_id"],
        exercise["exercise_order"],
        exercise["rx_reps"],
        exercise["rx_multiplier"],
        )
    end

    redirect request.path_info
  end

  get '/records/:workout_id' do
    @exercises = @e.get

    [200, erb(:"workout/add")]
  end

# Record new workout

# Show some crazy results

# "Show me all the times I've done this WoD. Plot results over time."
# "Show me all the pullups I've ever done"
#	"... now include all the exercises I did before a pullup"
#	"Which prior exercises are the most common?"
#	"Which subsquent exercises are the most common?"

end # end class
