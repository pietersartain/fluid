
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

# ====== HTML endpoints ======
# All of these should return HTML or redirects
  get '/' do
    [200, erb(:layout)]
  end

# View all exercises
  get '/exercises' do
    @exercises = @e.get
    [200, erb(:"exercise/list")]
  end

# View all workouts
  get '/workouts' do
    @workouts = @w.get
    [200, erb(:"workout/list")]
  end

# Add new workout
  get '/workouts/new' do
    @page_js = "add-workout.js"
    @exercises = @e.get
    [200, erb(:"workout/add")]
  end


# ====== API endpoints ======
# All of these should return JSON
# None should redirect
# These all effectively assume an
# if request.xhr? {}

  get '/api/exercises' do
    content_type :json
    @e.get.to_json
  end

  get '/api/exercise/:type' do
    content_type :json
    @e.get_details(params[:type]).to_json
  end

  get '/api/workouts' do
    content_type :json
    @w.get.to_json
  end

# Add a new exercise
  post '/api/exercises' do
    @e.add(params[:exercise_name], params[:exercise_unit])
    content_type :json
    @e.get.to_json
  end

# Add a new workout
  post '/api/workouts' do
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

    content_type :json
    @w.get.to_json
  end

# Record new workout

# Show some crazy results

# "Show me all the times I've done this WoD. Plot results over time."
# "Show me all the pullups I've ever done"
#	"... now include all the exercises I did before a pullup"
#	"Which prior exercises are the most common?"
#	"Which subsquent exercises are the most common?"

end # end class
