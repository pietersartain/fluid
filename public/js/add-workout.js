/*
 *
 */
var ExerciseModel = function() {
  this.exercises = ko.observableArray();

  // This is part of the constructor
  this.refreshExercises = function() {
    $.ajax({
      context: this,
      'url': '/api/exercises',
      'type': 'get',
      'success': function(data, status, jqxhr) {
        ko.mapping.fromJS(data, {}, this.exercises);
      },
      'error': function() {}
    });
  };

  this.insertExercise = function(form) {
      $.ajax({
        context: this,
        'url': '/api/exercises', // form.attr('action')
        'type': 'post', // form.attr('method')
        'data': form.serialize(),
        'success': function(data, status, jqxhr) {
          ko.mapping.fromJS(data, {}, this.exercises);
        },
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
};

var wm = new WorkoutModel();

$(document).ready(function() {
  ko.applyBindings(wm);

// Enhance "create new exercise" button
  $(window).on('shown.bs.popover', function() {
    $("[data-ajax-submit='add-exercise']").click(function (ev) {
      ev.preventDefault();
      wm.ExerciseModel.insertExercise($(this).parent());
    });
  });

});
