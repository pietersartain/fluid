/**
 *  ?_reps       = repititions (proscribed or recorded)
 *  ?_multiplier = weight (proscribed or recorded)
 */

/* DROP TABLE workouts; /**/
CREATE TABLE IF NOT EXISTS
workouts (
	workout_id INTEGER PRIMARY KEY,
	workout_name TEXT,
	scoring_description TEXT,
	scoring_unit TEXT
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
	workout_exercise_id INTEGER PRIMARY KEY,
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
/*	user_id INTEGER, */
	workout_result_id INTEGER PRIMARY KEY,
	workout_id INTEGER,
	score INTEGER,
	datetime INTEGER,
	FOREIGN KEY(workout_id) REFERENCES workouts(workout_id)
);

/* DROP TABLE workout_exercise_results /**/
CREATE TABLE IF NOT EXISTS
workout_exercise_results (
/*	user_id INTEGER, */
	exercise_result_id INTEGER PRIMARY KEY,
	workout_result_id INTEGER,
	workout_exercise_id INTEGER,
	actual_reps INTEGER,
	actual_multiplier INTEGER,
	FOREIGN KEY(workout_result_id) REFERENCES workout_results(workout_result_id),
	FOREIGN KEY(workout_exercise_id) REFERENCES workout_exercises(workout_exercise_id)
);
