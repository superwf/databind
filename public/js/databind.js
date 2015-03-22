(function($) {
  return $.extend({
    bind: function(element, obj, callback) {
      var pubSub;
      pubSub = $({});
      $(element).delegate("[data-bind]", "keyup mouseup change", function(evt) {
        var $this, attr, triggerName;
        $this = $(this);
        attr = $this.data("bind");
        triggerName = attr + ":change";
        pubSub.trigger(triggerName, $this.val());
      });
      $(element).find("[data-bind]").each(function() {
        var $this, attr, triggerName;
        $this = $(this);
        attr = $this.data("bind");
        if (obj.hasOwnProperty(attr)) {
          $this.val(obj[attr]);
        }
        triggerName = attr + ":change";
        pubSub.on(triggerName, function(evt, newVal) {
          obj[attr] = newVal;
          if ($.isFunction(callback)) {
            callback(obj, attr);
          }
        });
      });
    }
  });
})(jQuery);
