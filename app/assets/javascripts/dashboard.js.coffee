# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  helper = new Helpers()

  $(".watch").bind 'click', (event) ->
    event.preventDefault();
    url = $(event.target).closest("a").attr("href")
    $("#content").load(url+ "#content")
    helper.setFullScreen("content")
