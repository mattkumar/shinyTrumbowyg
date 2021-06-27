var trumbowygBinding = new Shiny.InputBinding();

$.extend(trumbowygBinding, {
  
  find: function(scope) {
    return $(scope).find('.trumbowygInput');
  },

  initialize: function(el) { 
     $(el).trumbowyg(JSON.parse(el.dataset.options)).on('trumbowyg.tbwchange', function(e) {
      $(el).trigger("tbwchange");
    });
  },

  getValue: function(el) {
    return $(el).trumbowyg('html');
  },

  setValue: function(el, value) {
    $(el).trumbowyg('html', value);
  },

  subscribe: function(el, callback) {
    $(el).on('tbwchange.trumbowygBinding', function(e) {
      callback();
    });
  },

  unsubscribe: function(el) {
    $(el).off('.trumbowygBinding');
  }
});

Shiny.inputBindings.register(trumbowygBinding);

