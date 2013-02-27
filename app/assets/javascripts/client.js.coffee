# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $("#typeDropDown").change ->
    getData = "?"
    helper = new Helpers()
    channel_id = helper.getParameterByName("channel")
    if channel_id
      getData += "channel=" + channel_id
    getData += "&type=" + $('select#typeDropDown :selected').val()
    window.location.replace('/slides/new'+ getData);
