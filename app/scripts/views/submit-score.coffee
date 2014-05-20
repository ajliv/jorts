define [
    'jquery'
    'underscore'
    'backbone'
    'templates'
    'models/score'
], ($, _, Backbone, JST, ScoreModel) ->
    class SubmitScoreView extends Backbone.View
        template: JST['app/scripts/templates/submit-score.ejs']

        id: 'submit-score'

        className: 'well'

        events: 
            'submit .score-form': 'submitScore'
            'keydown .score-form': 'inputName'

        initialize: () -> @render()

        render: () ->
            @$el.html @template @model.toJSON()
            @form = @$ '.score-form'
            @input = @form.find 'input[name=username]'
            @

        inputName: (e) =>
            false unless @input.val().length < 3 or e.keyCode is 8 or e.keyCode is 13

        submitScore: (e) =>
            e.preventDefault()

            username = $.trim @input.val()
            @input.val username

            if username.length > 3
                username = username.substring 0, 3

            if username.length <= 0
                @input.focus()
                return false 

            @model.save { username: username.toUpperCase() }, {
                success: => 
                    console.log 'saved'
                    @collection.getScores () => 
                        @remove()
                        window.vent.trigger 'score:submit' 
                error: -> window.vent.trigger 'score:submit' 
            }
