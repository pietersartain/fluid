$(function () { 

// Configuration function for Bootstrap's popover code
  $("[data-toggle='popover']").popover({
      'trigger': 'click'
      ,'placement': 'bottom'
      ,'html': 'true'
    });

});

// Allow drag and drop for exercises
// (used when making a new workout)
+function ($) {
  'use strict';

  var Exercise = function (element, options) {
    this.$element = $(element)
    this.options = $.extend({}, Exercise.DEFAULTS, options)
    this.isLoading = false
    this.exercise_list = [];

  }

  Exercise.VERSION = '1.0.0'

  Exercise.DEFAULTS = {
    loadingText: 'loading...'
  }


  Exercise.prototype.create = function (element) {
    $(element).children("li").each(function() {
      // $(ch).html("words words words");
      //console.log($(this).contents());
      $(this).draggable({ opacity: 0.7, helper: "clone" });
    });

    $("#workout_exercises").droppable({
      drop: function( event, ui ) {

        // Don't know why I do this ... stolen from unitbuilder
        if ($(ui.draggable).is("li")) {
          // Get the ID of the original <li>
          //var id = $(ui.draggable).attr('data-exercise-id');
          //var html = $(ui.draggable).html();

          // Need to replace this with something that does something
          $(this).append($(ui.draggable).clone());
        }
      }
    });
  };

  // // $.fn.scrollspy = Plugin
  // // $.fn.scrollspy.Constructor = Workout


  $(window).on('load.fluid.exercise.dragdrop', function () {
    $('[data-drag="exercise"]').each(function () {
      var Plugin = new Exercise(this, {});
      Plugin.create(this);
    });
  });

}(jQuery);

// Record workout
+function ($) {
  'use strict';

  var Workout = function (element, options) {
    this.$element = $(element)
    this.options = $.extend({}, Workout.DEFAULTS, options)
    this.isLoading = false
  }

  Workout.VERSION = '1.0.0'

  Workout.DEFAULTS = {
    loadingText: 'loading...'
  }

  Workout.prototype.create = function (element) {
    $(element).after("<div>Adding moar shit here</div>");
  };

  // $.fn.scrollspy = Plugin
  // $.fn.scrollspy.Constructor = Workout

  $(window).on('load.fluid.workout.record', function() {
    $('[data-replace="record"]').each(function () {
      var Plugin = new Workout(this, {});
      Plugin.create(this)
    });
  });

}(jQuery);

// Create new workout
+function ($) {
  'use strict';

  var Workout = function (element, options) {
    this.$element = $(element)
    this.options = $.extend({}, Workout.DEFAULTS, options)
    this.isLoading = false
  }

  Workout.VERSION = '1.0.0'

  Workout.DEFAULTS = {
    loadingText: 'loading...'
  }


  Workout.prototype.create = function (element) {
    $(element).after("<div>Adding shit here</div>");
  };

  // $.fn.scrollspy = Plugin
  // $.fn.scrollspy.Constructor = Workout


  $(window).on('load.fluid.workout.create', function () {
    $('[data-replace="create"]').each(function () {
      var Plugin = new Workout(this, {});
      Plugin.create(this);
    });
  });

}(jQuery);