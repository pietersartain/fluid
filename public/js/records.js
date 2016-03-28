/*
 *
 */
var RecordModel = function() {
  this.workouts = ko.observableArray();
  this.record = ko.observableArray();
  var self = this;

  this.refreshWorkouts = function() {
    $.ajax({
      context: this,
      'url': '/api/workouts',
      'type': 'get',
      'success': function(data, status, jqxhr) {
        ko.mapping.fromJS(data, {}, this.workouts);

        $("#workouts li > a").click(function(ev) {
          ev.preventDefault();
          var id = $(this).attr('data-workout-id');
          self.getWorkoutRecords(id);
        });
      },
      'error': function() {}
    });
  };

  this.getWorkoutRecords = function(workout_id) {
    $.ajax({
      context: this,
      'url': '/api/workout/' + workout_id,
      'type': 'get',
      'success': function(data, status, jqxhr) {

        var mappingOptions = {
          'results': {
            // overriding the default creation / initialization code
            create: function (options) {

              return (new (function () {
                ko.mapping.fromJS(options.data, {}, this);

                // 
                this.readable_date = ko.pureComputed(function () {
                  return moment(this.datetime, "X").format("MM/DD/YYYY");;
                }, this);

                //
                this.proximity = ko.pureComputed(function(){
                  return 0;
                });

              })());
            }
          }
        };

        ko.mapping.fromJS(data, mappingOptions, this.record);
        $("#datetimepicker1").datetimepicker({
          pickTime: false,
          language: 'gb',
          defaultDate: moment().format("MM/DD/YYYY")
        });

        // "Record workout" button
        $("#workout-record input[type='submit']").click(function(){
          self.insertRecord();
        });
      },
      'error': function() {}
    });
  };


// {
//   "workout_id":"3",
//   "workout_score":"111",
//   "workout_datetime":"00000000"
//   "workout_exercise_results":
//   [
//     {"exercise_id":"1","actual_reps":"2"},
//     {"exercise_id":"3","actual_reps":"3"},
//     {"exercise_id":"5","actual_reps":"4", "actual_multiplier":"4"}
//   ]
// }
  this.insertRecord = function() {
    var json_record = ko.toJS(this.record)[0];
    json_record.workout.score = $("input[name='score']").prop('value');
    json_record.workout.datetime = moment($("#datetimepicker1").data("DateTimePicker").getDate()).format("X");
    json_record = ko.toJSON(json_record);
    $.ajax({
      context: this,
      'url': '/api/records', // form.attr('action')
      'type': 'post', // form.attr('method')
      'data': "record=" + json_record,
      'success': function(data, status, jqxhr) {
        // Update the records
        this.getWorkoutRecords(data.workout_id);
      },
      'error': function() {}
    });
  }

  this.refreshWorkouts();
};

$(document).ready(function() {

  // Tie bindings
  var rm = new RecordModel();
  ko.applyBindings(rm);

});
