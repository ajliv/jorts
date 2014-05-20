define [
    'jquery'
    'underscore'
    'backbone'
    'templates'
], ($, _, Backbone, JST) ->
    class HighScoresView extends Backbone.View
        template: JST['app/scripts/templates/high-scores.ejs']

        id: 'high-scores'

        className: 'col-xs-12 col-sm-6 col-sm-offset-3'

        events: {}

        initialize: () ->
            @listenTo @collection, 'reset', @render
            @render()

        render: () ->
            @$el.html @template scores: @collection.toJSON()
            @
