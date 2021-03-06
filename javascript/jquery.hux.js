// Generated by CoffeeScript 1.10.0
(function() {
  (function($) {
    return $.fn.hux = function(hideOnClose) {
      var content, flag, hotspotEl, huxElement, huxOnClick, i, id, len, ref, results, title, triggerEl;
      this.hideOnClose = hideOnClose != null ? hideOnClose : false;
      this.addClass('hux-container');
      this.huxElements = this.find('.hux-element');
      huxOnClick = (function(_this) {
        return function(e) {
          if (hotspotEl.hasClass('open')) {
            hotspotEl.removeClass('open');
            _this.trigger('hux:closed', {
              flag: flag
            });
            if (_this.hideOnClose) {
              hotspotEl.fadeOut(400);
              return _.delay(hotspotEl.remove, 400);
            }
          } else {
            hotspotEl.addClass('open');
            return _this.trigger('hux:opened', {
              flag: flag
            });
          }
        };
      })(this);
      if (this.huxElements.length) {
        ref = this.huxElements;
        results = [];
        for (i = 0, len = ref.length; i < len; i++) {
          huxElement = ref[i];
          huxElement = $(huxElement);
          if (!huxElement.attr('hux-disabled')) {
            flag = huxElement.data('hux-flag');
            id = 'hux-' + Math.floor(Math.random() * 25.);
            content = huxElement.data('hux-content');
            title = huxElement.data('hux-title');
            huxElement.addClass('hux-target').data('hux-element-id', id);
            hotspotEl = $("<div class='hux-hotspot' id='" + id + "'> <div class='hux-trigger'> <div class='hux-pulse'></div> <div class='hux-dot'> <span class='open'>?</span> <span class='dismiss'>+</span> </div> </div> <div class='hux-inner'> " + (title != null ? '<div class="hux-title">' + title + '</div>' : '') + " <div class='hux-content'> " + content + " </div> </div> </div>");
            triggerEl = hotspotEl.find('.hux-trigger');
            triggerEl.on('click', huxOnClick);
            results.push(huxElement.append(hotspotEl));
          } else {
            results.push(void 0);
          }
        }
        return results;
      } else {
        return console.log("(Hux) We couldn't find any hux elements on your page.");
      }
    };
  })(jQuery);

}).call(this);
