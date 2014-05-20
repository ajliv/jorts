define [
    'jquery'
    'underscore'
    'backbone'
    'templates'
    'views/question'
], ($, _, Backbone, JST, QuestionView) ->
    class GameView extends Backbone.View
        id: 'game'

        initialize: () ->
            @listenTo @model, 'change:answered', @render
            @model.set 
                answered: 0
                wrong: 0

        render: () => 
            if @model.get('wrong') >= 3
                JORTS.vent.trigger 'game:over', @model.get 'score'
                @remove()
            else
                question = @collection.at @model.get 'answered'
                @$el.html new QuestionView( model: question, game: @model ).render().el

            @
