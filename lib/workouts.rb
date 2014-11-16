class Workouts

  def initialize(db)
    @db = db
  end

  # Workouts
  def get(workout_id = nil, number = nil, user = nil)
    
    if workout_id.nil? then
      workouts = @db.execute("SELECT * FROM workouts")
    else
      workouts = @db.execute("SELECT * FROM workouts WHERE workout_id = ?", [workout_id])
    end

    workouts.map! do |x|
      { "workout" => x,
        "exercises" => get_details(x["workout_id"].to_i),
        "results" => get_records(x["workout_id"].to_i)
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
    @db.last_insert_row_id
  end

  def record(workout_id, score, datetime)
    @db.execute("insert into workout_results(workout_id, score, datetime) values(?,?,?)",
      [workout_id, score, datetime])
    return @db.last_insert_row_id
  end

  def get_records(workout_id)
    return @db.execute("SELECT * FROM workout_results WHERE workout_id = ?",[workout_id])
  end

  def get_record_details(workout_id)
  end

end
