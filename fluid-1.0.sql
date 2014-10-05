/* DROP TABLE workouts; /**/
CREATE TABLE IF NOT EXISTS
workouts (
	workout_id INTEGER PRIMARY KEY,
	workout_name TEXT,
	scoring_description TEXT
);

/* DROP TABLE exercises; /**/
CREATE TABLE IF NOT EXISTS
exercises (
	exercise_id INTEGER PRIMARY KEY,
	exercise_name TEXT,
	exercise_unit TEXT /* (kg, ??) */
);

/* DROP TABLE workout_exercises; /**/
CREATE TABLE IF NOT EXISTS
workout_exercises (
	workout_id INTEGER,
	exercise_id INTEGER,
	exercise_order INTEGER,
	rx_reps INTEGER,
	rx_multiplier INTEGER,
	FOREIGN KEY(workout_id) REFERENCES workouts(workout_id),
	FOREIGN KEY(exercise_id) REFERENCES exercises(exercise_id)
);

/* DROP TABLE workout_results /**/
CREATE TABLE IF NOT EXISTS
workout_results (
	workout_result_id INTEGER PRIMARY KEY,
	workout_id INTEGER,
/*	user_id */
	score TEXT,
	FOREIGN KEY(workout_id) REFERENCES workouts(workout_id)
);

/* DROP TABLE workout_exercise_results /**/
CREATE TABLE IF NOT EXISTS
workout_exercise_results (
	exercise_result_id INTEGER PRIMARY KEY,
	exercise_id INTEGER,
	workout_id INTEGER,
/*	user_id */
	actual_reps INTEGER,
	score TEXT,
	FOREIGN KEY(workout_id) REFERENCES workouts(workout_id),
	FOREIGN KEY(exercise_id) REFERENCES exercises(exercise_id)
);
