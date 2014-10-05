require 'sqlite3'

class Dbhelper

	#@db = nil

	def initialize(*args)
		@db = SQLite3::Database.new "fluid.db"
    @db.results_as_hash = true
    init
    add_test_data
	end

	def init
    sql = IO.read("fluid-1.0.sql")
    print "Running SQL initializer ... "
    @db.execute_batch(sql)
    print "complete.\n"
	end

  def deinit
    File.delete("fluid.db")
  end

  def add_test_data
    sql = IO.read("fluid-test.sql")
    print "Adding test data ... "
    @db.execute_batch(sql)
    print "complete.\n"
  end

  def last_insert_row_id
    return @db.last_insert_row_id
  end

  # Exercises
  def get_exercises(number = nil, user = nil)
    return @db.execute "select * from exercises"
  end

  def add_exercise(name, unit)
    @db.execute("insert into exercises(exercise_name, exercise_unit) values(?,?)",
      [name, unit])
  end

  # Workouts
  def get_workouts(number = nil, user = nil)
    workouts = @db.execute("select * from workouts")

    workouts.map! do |x|
      { "workout" => x,
        "exercises" => get_workout_details(x["workout_id"].to_i)
      }
    end  

    return workouts
  end

  # def get_workouts(number = nil, user = nil)
  #   return @db.execute("SELECT * FROM workout_exercises AS we
  #     JOIN workouts  AS w ON w.workout_id  = we.workout_id
  #     JOIN exercises AS e ON e.exercise_id = we.exercise_id
  #     ORDER BY we.exercise_order")
  # end

  def get_workout_details(workout_id)
    return @db.execute("SELECT * FROM workout_exercises AS we
      JOIN workouts  AS w ON w.workout_id  = we.workout_id
      JOIN exercises AS e ON e.exercise_id = we.exercise_id
      WHERE w.workout_id = ? 
      ORDER BY w.workout_id, we.exercise_order", [workout_id])
  end

  def add_workout(name, scoring)
    @db.execute("insert into workouts(workout_name, scoring_description) values(?,?)",
      [name, scoring])
  end

  def add_exercise_to_workout(workout_id, exercise_id, exercise_order, rx_reps, rx_multiplier)
    @db.execute("insert into workout_exercises(workout_id, exercise_id, exercise_order, rx_reps, rx_multiplier) values(?,?,?,?,?)",
      [workout_id, exercise_id, exercise_order, rx_reps, rx_multiplier])
  end

  # Results
  def record_workout_result(workout_id, score)
    @db.execute("insert into workout_results(workout_id, score) values(?,?)",
      [workout_id, score])
  end

  #def record_exercise_result(exercise_id)

end