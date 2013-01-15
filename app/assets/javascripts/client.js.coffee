# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->

  $("#typeDropDown").change -> 
    type = $('select#typeDropDown :selected').val()
    jQuery.get '/slides/update_type_selection/'+ type, (data) ->
      $("#slideForm").html(data)

#      if(data.type == "YoutubeSlide")
#              YT_ready ->
#                frameID = getFrameID("channel")
#                if(frameID)
#                  player = new YT.Player(frameID, () ->
#                    events: () ->
#                      "onStateChange": (event) ->
#                        if(event.data == 0)
#                          alert "moi"
#                  )