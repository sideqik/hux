# Hux, a jQuery plugin for showing people how things work in a non-linear fashion.
# * Don't Use Tours, They're For Resistance Scum! *

(($) ->
  $.fn.hux = (@hideOnClose = false) ->
    @addClass 'hux-container'
    @huxElements = @find '.hux-element'

    huxOnClick = (e) =>
      if hotspotEl.hasClass 'open'
        hotspotEl.removeClass 'open'
        @trigger 'hux:closed', flag: flag
        if @hideOnClose
          hotspotEl.fadeOut(400)
          _.delay hotspotEl.remove, 400
      else
        hotspotEl.addClass 'open'
        @trigger 'hux:opened', flag: flag

    if @huxElements.length
      for huxElement in @huxElements
        huxElement = $(huxElement)
        unless huxElement.attr 'hux-disabled'
          flag = huxElement.data 'hux-flag'
          id = 'hux-' + Math.floor(Math.random() * (25))
          content = huxElement.data 'hux-content'
          title = huxElement.data 'hux-title'
          huxElement.addClass('hux-target').data 'hux-element-id', id
          hotspotEl = $("
            <div class='hux-hotspot' id='#{id}'>
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
              </div>
            </div>")
          triggerEl = hotspotEl.find('.hux-trigger')
          triggerEl.on 'click', huxOnClick
          huxElement.append hotspotEl
    else
      console.log "(Hux) We couldn't find any hux elements on your page."

) jQuery
