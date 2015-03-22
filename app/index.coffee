$ ->
  user = {
    name: "ffff"
  }

  $form = $("#form")
  $form1 = $("#form1")

  $.bind($form, user, (newUser, attr)->
    console.log "user name is " + newUser[attr]
    $form1.find("[data-bind="+attr+"]").val(newUser[attr])
  )

  $.bind($form1, user, (newUser, attr)->
    console.log "user name is " + newUser[attr]
    $form.find("[data-bind="+attr+"]").val(newUser[attr])
  )
  console.log 124
  return
