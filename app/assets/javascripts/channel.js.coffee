# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  channel_id = $('[id^=channel_id_]').attr('id').substr(11)
  init_sortable= () ->
    $('#channel_slides').sortable
      revert: true
      connectWith: '#all_slides'
      accept: 'all_slides'
      over: (event, ui) ->
        ui.sender.addClass('drag_over')
      out: (event, ui) ->
        ui.sender.removeClass('drag_over')
      update: (event, ui) ->
        item = ui.item.first()
        slide_id = item.find('input[name=slide_id]').val()
        channel_slide_id = item.find('input[name=channelslide_id]').val()
        index = parseInt(item.index())
        if channel_slide_id.length > 0
          $.ajax
            type: 'PUT'
            dataType: 'json'
            data: 'channel_slide[position]='+index
            url: '/channels/' + channel_id + '/slides/' + channel_slide_id
        else
          $.ajax
            type: 'POST'
            data: {slide_id: slide_id, position: index}
            el: item
            url: '/channels/' + channel_id + '/slides'
            success: (data)->
              updated_channels = $(data).find('#channel_slides')
              $('#channel_slides').replaceWith(updated_channels)
              init_sortable()
    .disableSelection();

    $('#all_slides li').draggable
      connectToSortable: '#channel_slides'
      helper: 'clone'
      rever: 'invalid'
      start: (e, ui) ->
        $(ui.helper).addClass('ui-draggable-helper')
        return

    $('.remove_button').bind 'click', (e)->
      e.preventDefault()
      channel_slide_id = $(e.target).closest('li').find('input[name=channelslide_id]').val()
      $.ajax
        url: '/channels/' + channel_id + '/slides/' + channel_slide_id
        data: ''
        type: 'DELETE'
        success: (data)->
          updated_channels = $(data).find('#channel_slides')
          $('#channel_slides').replaceWith(updated_channels)
          init_sortable()
        error: (data) ->
          alert "can't delete last slide"


    .disableSelection();

  init_sortable()
  $('#channel_edit_icon').click ->
    $('#channel_edit_forms').toggle()
