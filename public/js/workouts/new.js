/*
 *
 */
var ExerciseModel = function() {
  this.exercises = ko.observableArray();

  this.exerciseList = function(data, status, jqxhr) {
    ko.mapping.fromJS(data, {}, this.exercises);

    $("[data-drag='exercise']").children("li").each(function() {
      $(this).draggable({ opacity: 0.7, helper: "clone" });
    });
  };

  // This is part of the constructor
  this.refreshExercises = function() {
    $.ajax({
      context: this,
      'url': '/api/exercises',
      'type': 'get',
      'success': this.exerciseList,
      'error': function() {}
    });
  };

  this.insertExercise = function(form) {
      $.ajax({
        context: this,
        'url': '/api/exercises', // form.attr('action')
        'type': 'post', // form.attr('method')
        'data': form.serialize(),
        'success': this.exerciseList,
        'error': function() {}
      });
  };

  this.refreshExercises();
};

/*
 *
 */
var WorkoutModel = function() {
  this.ExerciseModel = new ExerciseModel();
  this.workout = {
    "workout_name":null,
    "scoring_unit":null,
    "scoring_description":null,
    "workout_exercises": ko.observableArray()
  };

// {"workout_name":"NewWOD","scoring_description":"Yayyy",
//   "workout_exercises":
//   [
//     {"exercise_id":"1","rx_reps":"210"},
//     {"exercise_id":"3","rx_reps":"211"},
//     {"exercise_id":"5","rx_reps":"212", "rx_multiplier":"8"}
//   ]
// }

  this.addExerciseToWorkout = function(exercise_id) {
    $.ajax({
      context: this,
      'url': '/api/exercise/' + exercise_id,
      'type': 'get',
      'success': function(data, status, jqxhr) {
        this.workout.workout_exercises.push({
          'exercise_id': data[0].exercise.exercise_id,
          'exercise_name': data[0].exercise.exercise_name,
          'exercise_unit': data[0].exercise.exercise_unit,
          'rx_reps': '',
          'rx_multiplier': ''
        });
        this.hookSortableExercises();
      },
      'error': function() {}
    });
  };

  this.hookSortableExercises = function() {
    $( "#workout_exercises ul" ).sortable({
      revert: true
    });
  };

  this.insertWorkout = function() {
    var json_exercises = ko.toJSON(this.workout);
    $.ajax({
      context: this,
      'url': '/api/workouts', // form.attr('action')
      'type': 'post', // form.attr('method')
      'data': "workout=" + json_exercises,
      'success': function() {},
      'error': function() {}
    });
  };

};

$(document).ready(function() {

  // Tie bindings
  var wm = new WorkoutModel();
  ko.applyBindings(wm);

  // Configuration function for Bootstrap's popover code
  $("[data-toggle='popover']").popover({
      'trigger': 'click'
      ,'placement': 'bottom'
      ,'html': 'true'
    });

  // "Create new exercise" button
  $(window).on('shown.bs.popover', function() {
    $("[data-ajax-submit='add-exercise']").click(function (ev) {
      ev.preventDefault();
      wm.ExerciseModel.insertExercise($(this).parent());
    });
  });

  // Drop area
  $("#workout_exercises").droppable({
    drop: function( event, ui ) {

      // We drop one of two things on the drop area
      // 1. An exercise from the exercise menu
      if ($(ui.draggable).attr('data-exercise-id')) {
        // Get the ID of the original <li>
        var id = $(ui.draggable).attr('data-exercise-id');
        //var html = $(ui.draggable).html();

        // Need to replace this with something that does something
        //$(this).append($(ui.draggable).clone());

        wm.addExerciseToWorkout(id);
      } else 
      // 2. When re-storting the exercises that have alread been brought in
      {

      }
    }
  });

  // "Create new workout" button
  $("#workouts-new > input[type='submit']").click(function(){
    wm.insertWorkout();
  });

});
