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
