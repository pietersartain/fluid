class Workouts

  def initialize(db)
    @db = db
  end

  # Workouts
  def get(number = nil, user = nil)
    workouts = @db.execute("select * from workouts")

    workouts.map! do |x|
      { "workout" => x,
        "exercises" => get_details(x["workout_id"].to_i)
      }
    end  

    return workouts
  end

  def get_details(workout_id)
    return @db.execute("SELECT * FROM workout_exercises AS we
      JOIN workouts  AS w ON w.workout_id  = we.workout_id
      JOIN exercises AS e ON e.exercise_id = we.exercise_id
      WHERE w.workout_id = ? 
      ORDER BY w.workout_id, we.exercise_order", [workout_id])
  end

  def add(name, description, unit)
    @db.execute("INSERT INTO workouts
      (workout_name, scoring_description, scoring_unit)
      VALUES(?,?,?)",
      [name, description, unit])
    return @db.last_insert_row_id
  end

  def add_exercise(workout_id, exercise_id, exercise_order, rx_reps, rx_multiplier)
    @db.execute("insert into workout_exercises(workout_id, exercise_id, exercise_order, rx_reps, rx_multiplier) values(?,?,?,?,?)",
      [workout_id, exercise_id, exercise_order, rx_reps, rx_multiplier])
  end

  def record(workout_id, score)
    @db.execute("insert into workout_results(workout_id, score) values(?,?)",
      [workout_id, score])
  end

end
