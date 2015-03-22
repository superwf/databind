$(function() {
  var $form, $form1, user;
  user = {
    name: "ffff"
  };
  $form = $("#form");
  $form1 = $("#form1");
  $.bind($form, user, function(newUser, attr) {
    console.log("user name is " + newUser[attr]);
    return $form1.find("[data-bind=" + attr + "]").val(newUser[attr]);
  });
  $.bind($form1, user, function(newUser, attr) {
    console.log("user name is " + newUser[attr]);
    return $form.find("[data-bind=" + attr + "]").val(newUser[attr]);
  });
  return console.log(124);
});
