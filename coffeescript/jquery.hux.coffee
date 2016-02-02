# Hux, a jQuery plugin for showing people how things work in a non-linear fashion.
# * Don't Use Tours, They're For Resistance Scum! *

(($) ->
  $.fn.hux = (@hideOnClose = false, @showCloseBtn = true) ->
    @addClass 'hux-container'
    @huxElements = @find '.hux-element'

    huxOnClick = (e) =>
      [hotspotEl, flag] = [e.data.hotspotEl, e.data.flag]
      if hotspotEl.hasClass 'open'
        hotspotEl.removeClass 'open'
        @trigger 'hux:closed', { flag: flag }
        if @hideOnClose
          hotspotEl.fadeOut(400)
          _.delay (-> hotspotEl.remove()), 400
      else
        hotspotEl.addClass 'open'
        @trigger 'hux:opened', { flag: flag }

    huxOnHover = (e) =>
      [hotspotEl, flag] = [e.data.hotspotEl, e.data.flag]
      unless hotspotEl.hasClass 'open'
        hotspotEl.addClass 'open'
        @trigger 'hux:opened', { flag: flag }

    if @huxElements.length
      for huxElement in @huxElements
        huxElement = $(huxElement)
        unless huxElement.is '[hux-disabled]'
          flag = huxElement.data 'hux-flag'
          id = 'hux-' + Math.floor(Math.random() * (1000))
          content = huxElement.data 'hux-content'
          title = huxElement.data 'hux-title'
          huxElement.addClass('hux-target').data 'hux-element-id', id
          hotspotEl = $("
            <div class='hux-hotspot' id='#{id}' style='display: block;'>
              <div class='hux-trigger'>
                <div class='hux-pulse'></div>
                <div class='hux-dot'>
                  <span class='open'>?</span>
                  <span class='dismiss'>+</span>
                </div>
              </div>
              <div class='hux-inner'>
                #{if title? then '<div class="hux-title">' + title + '</div>' else ''}
                <div class='hux-content'>
                  #{content}
                </div>
                <br/>
                #{if @showCloseBtn then "<button class='hux-close btn btn-default'>Got It</button>" else ''}
              </div>
            </div>")
          triggerEl = hotspotEl.find('.hux-trigger, .hux-close')
          data = {hotspotEl: hotspotEl, flag: flag}
          triggerEl.on 'click', data, huxOnClick
          triggerEl.on 'mouseover', data, huxOnHover
          huxElement.append hotspotEl
    else
      console.log "(Hux) We couldn't find any hux elements on your page."

) jQuery
