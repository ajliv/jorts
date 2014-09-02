define [
    'jquery'
    'underscore'
    'backbone'
    'templates'
], ($, _, Backbone, JST) ->
    class QuestionView extends Backbone.View
        template: JST['app/scripts/templates/question.ejs']
        answeredTemplate: JST['app/scripts/templates/answer.ejs']

        className: 'question clearfix'

        events: 
            'click .answer': 'answer'
            'click .next-question': 'next'

        initialize: (options) ->
            @game = options.game

        render: () ->
            @$el.html @template @data()
            @

        answer: (e) =>
            answer = if $(e.currentTarget).hasClass 'answer-yeah' then true else false
            correct = answer is @model.get 'value'

            e.preventDefault()
            e.stopPropagation()

            if correct
                @game.set score: @game.get('score') + 1
            else 
                @game.set wrong: @game.get('wrong') + 1

            if @game.get('wrong') >= 3
                @next()
            else
                @$el.html @answeredTemplate @data()

            @

        next: () => 
            @game.set answered: @game.get('answered') + 1

        data: () =>
            data = @model.toJSON()
            data.game = @game.toJSON()
            data