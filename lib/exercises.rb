class Exercises

  def initialize(db)
    @db = db
  end

  # Exercises
  def get(number = nil, user = nil)
    exercises = @db.execute("SELECT * FROM exercises")

    exercises.map! do |x|
      { "exercise" => x,
        "workouts" => get_details(x["exercise_id"].to_i)
      }
    end

    return exercises
  end

  def get_details(exercise_id)
    return @db.execute("SELECT * FROM workout_exercises AS we
      JOIN workouts  AS w ON w.workout_id  = we.workout_id
      JOIN exercises AS e ON e.exercise_id = we.exercise_id
      WHERE e.exercise_id = ? 
      ORDER BY w.workout_id, we.exercise_order 
      ", [exercise_id])
  end

  def add(name, unit)
    @db.execute("INSERT INTO exercises(exercise_name, exercise_unit) 
      VALUES(?,?)",
      [name, unit])
    return @db.last_insert_row_id
  end

  def record(workout_exercise_id, actual_reps, actual_multiplier)
    @db.execute("INSERT INTO workout_exercise_results
      (workout_exercise_id, actual_reps, actual_multiplier
      VALUES(?,?,?)",
      [workout_exercise_id, actual_reps, actual_multiplier])
    return @db.last_insert_row_id
  end

end
