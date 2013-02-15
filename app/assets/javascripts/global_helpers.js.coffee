class @Helpers

  getChannels: () ->
      $.ajax
        url: '/'
        dataType: 'html'
        async: true
        success: (data) ->
          $("body").load()

  getParameters: () ->
      params_arr = window.location.search.substr(1)
      params_arr = params_arr.split("&")
      params = {}
      i = 0

      while i < prmarr.length
        tmparr = prmarr[i].split("=")
        params[tmparr[0]] = tmparr[1]
        i++
      return params

  getParameterByName: (key) ->
      params_arr = window.location.search.substr(1)
      params_arr = params_arr.split("&")
      params = {}
      i = 0

      while i < params_arr.length
        tmparr = params_arr[i].split("=")
        params[tmparr[0]] = tmparr[1]
        i++
        if tmparr[0] == key
          return tmparr[1]
      return false

  changeUrlParam: (key, new_value) ->
      req = new RegExp key+"=\\S", 'g'
      parameter = "&"+key+"="+new_value
      if window.location.search.match(req) == null
        window.location.search + parameter
      else
        window.location.search.replace(req, key+"="+new_value)

  getCurrentPage: () ->
    current_page = if @getParameterByName("page") then parseInt(@getParameterByName("page")) else 1

  setFullScreen: (container) ->
    element = document.getElementById(container.toString());
    if element.mozRequestFullScreen
      element.mozRequestFullScreen();
    else if element.webkitRequestFullScreen
      element.webkitRequestFullScreen();



