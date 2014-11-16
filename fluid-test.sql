/* Exercises without multipliers */
INSERT INTO exercises(exercise_name) VALUES("Pullups");
INSERT INTO exercises(exercise_name) VALUES("Pushups");
INSERT INTO exercises(exercise_name) VALUES("Situps");
INSERT INTO exercises(exercise_name) VALUES("Burpees");

/* Exercises with multipliers */
INSERT INTO exercises(exercise_name,exercise_unit) VALUES("Strict press","kg");
INSERT INTO exercises(exercise_name,exercise_unit) VALUES("Push press","kg");
INSERT INTO exercises(exercise_name,exercise_unit) VALUES("Push jerk","kg");
INSERT INTO exercises(exercise_name,exercise_unit) VALUES("Thrusters","kg");


/* Workout A */
INSERT INTO workouts(workout_name, scoring_description, scoring_unit) VALUES("Workout A", "AMRAP", "rounds");
INSERT INTO workout_exercises(workout_id, exercise_id, exercise_order, rx_reps)
 VALUES(1, 1, 1, 10);
INSERT INTO workout_exercises(workout_id, exercise_id, exercise_order, rx_reps)
 VALUES(1, 2, 2, 11);
INSERT INTO workout_exercises(workout_id, exercise_id, exercise_order, rx_reps)
 VALUES(1, 3, 3, 12);
INSERT INTO workout_exercises(workout_id, exercise_id, exercise_order, rx_reps)
 VALUES(1, 4, 4, 13);


/* Workout B */
INSERT INTO workouts(workout_name, scoring_description, scoring_unit) VALUES("Workout B", "Do stuff", "time");
INSERT INTO workout_exercises(workout_id, exercise_id, exercise_order, rx_reps, rx_multiplier)
 VALUES(2, 5, 1, 111, 222);
INSERT INTO workout_exercises(workout_id, exercise_id, exercise_order, rx_reps, rx_multiplier)
 VALUES(2, 6, 2, 112, 223);
INSERT INTO workout_exercises(workout_id, exercise_id, exercise_order, rx_reps, rx_multiplier)
 VALUES(2, 7, 3, 113, 224);

/* Workout - Fran */
INSERT INTO workouts(workout_name, scoring_description, scoring_unit) VALUES("Fran", "Do things", "time");
INSERT INTO workout_exercises(workout_id, exercise_id, exercise_order, rx_reps, rx_multiplier)
 VALUES(3, 8, 1, 21, 45);
INSERT INTO workout_exercises(workout_id, exercise_id, exercise_order, rx_reps)
 VALUES(3, 1, 2, 21);
INSERT INTO workout_exercises(workout_id, exercise_id, exercise_order, rx_reps, rx_multiplier)
 VALUES(3, 8, 3, 15, 45);
INSERT INTO workout_exercises(workout_id, exercise_id, exercise_order, rx_reps)
 VALUES(3, 1, 4, 15);
INSERT INTO workout_exercises(workout_id, exercise_id, exercise_order, rx_reps, rx_multiplier)
 VALUES(3, 8, 5, 9, 45);
INSERT INTO workout_exercises(workout_id, exercise_id, exercise_order, rx_reps)
 VALUES(3, 1, 6, 9);



/* Result for Workout A */
INSERT INTO workout_results(workout_id, score, datetime) VALUES(1,"10",0);
INSERT INTO workout_exercise_results(workout_result_id, workout_exercise_id,
  actual_reps, actual_multiplier)
  VALUES(1, 1, 11, 101);
INSERT INTO workout_exercise_results(workout_result_id, workout_exercise_id,
  actual_reps, actual_multiplier)
  VALUES(1, 2, 21, 201);
INSERT INTO workout_exercise_results(workout_result_id, workout_exercise_id,
  actual_reps, actual_multiplier)
  VALUES(1, 3, 31, 301);
INSERT INTO workout_exercise_results(workout_result_id, workout_exercise_id,
  actual_reps, actual_multiplier)
  VALUES(1, 4, 41, 401);

/*
INSERT INTO workout_exercise_results(exercise_id, workout_id, actual_reps, score)
 VALUES()
 */