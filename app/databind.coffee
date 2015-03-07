(($)->
  $.extend {
    # element is the jquery element or selector string
    # obj is the js object that will be binded
    # if has callback, the callback has two params (obj, attr)
    bind: (element, obj, callback)->
      pubSub = $({})

      $(element).delegate "[data-bind]", "keyup mouseup change", (evt)->
        $this = $(this)
        attr = $this.data("bind")
        triggerName = attr + ":change"
        pubSub.trigger triggerName, $this.val()
        return

      $(element).find("[data-bind]").each ->
        $this = $(this)
        attr = $this.data("bind")
        if obj.hasOwnProperty attr
          $this.val obj[attr]
        triggerName = attr + ":change"
        pubSub.on triggerName, (evt, newVal)->
          obj[attr] = newVal
          if $.isFunction(callback)
            callback obj, attr
          return
        return

      return
  }
)(jQuery)
