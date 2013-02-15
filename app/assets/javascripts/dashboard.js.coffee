# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  helper = new Helpers()
  current_page = parseInt(helper.getParameterByName("page"))
  if current_page < 2
    $(".icon-arrow-left").addClass("disabled_link")

  $(".watch").bind 'click', (event) ->
    event.preventDefault();
    url = $(event.target).closest("a").attr("href")
    $("#content").load(url+ "#content")
    helper.setFullScreen("content")


  $("#previous").bind 'click', (event) ->
    event.preventDefault()
    if $(".icon-arrow-left").hasClass("disabled_link")
      return
    current_page = helper.getCurrentPage()
    window.location.search = helper.changeUrlParam("page", (current_page-1).toString())
    $("#content").load(window.location.search).fadeIn()

  $("#next").bind 'click', (event) ->
    event.preventDefault()
    if $(".icon-arrow-right").hasClass("disabled_link")
      return
    current_page = helper.getCurrentPage()
    window.location.search = helper.changeUrlParam("page", (current_page+1).toString())
    $("#content").load(window.location.search).fadeIn()




