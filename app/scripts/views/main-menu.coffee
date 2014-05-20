define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
], ($, _, Backbone, JST) ->
  class MainMenuView extends Backbone.View
    template: JST['app/scripts/templates/main-menu.ejs']

    id: 'main-menu'

    className: 'well clearfix'

    initialize: () -> @render()

    render: () ->
        @$el.html @template()
